class DepartmentAndSpecialityValidator < ActiveModel::Validator
  def validate(record)
    unless record.department.blank? || record.department =~ /^[[空,无]$]/|| d=Department.where(name: record.department)[0]
        record.errors[:department] << "学院不存在"
        return
    end
    unless record.speciality.blank? || record.department =~ /^[[空,无]$]/|| d.specialities.where(name: record.speciality)[0]
      record.errors[:speciality] << "该学院不存在该专业"
    end
  end
end

class User < ApplicationRecord
    include NotificationsHelper
    include ActiveModel::Validations
    # constants
    NAME_FORMAT = /\A[\w]+\z/
    NICK_FORMAT = /\A[\u4e00-\u9fa5a-zA-Z0-9]+\Z/
    EMAIL_FORMAT = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    PHONE_NUMBER_FORMAT = /\A[0-9]{11}\z/
    
    # callback
    before_save :before_save
    after_create :after_initial
    
    # validates
    validates_with DepartmentAndSpecialityValidator
    validates :username, presence: {message: "用户名不能为空"},
                        length: {in: 3..20, message: "用户名长度必须为1-20字之间"},
                        format: {with: NAME_FORMAT, message: "用户名只能含英文字母，数字，下划线"},
                        uniqueness: {message: "用户名已被使用"}
    
    validates :nickname, presence: {message: "昵称不能为空"},
                        length: {in: 1..20, message: "昵称长度必须为1-20字之间"},
                        format: {with: NICK_FORMAT, message: "昵称含非法字符"},
                        uniqueness: {message: "昵称已被使用"}
                        
    validates :password, presence: {message: "密码不能为空"},
                        length: {in: 6..20, message: "密码必须为6-20位字符"}, on: :create
                        
    validates :email, presence: {message:
    "电子邮件不能为空"},
                        length: { maximum: 255 ,message: "电子邮件不能超过255字符"}, 
                        format: { with: EMAIL_FORMAT ,message: "电子邮件格式错误"},
                        uniqueness: {case_sensitive: false ,message: "电子邮件已被使用"}
                        
    validates :phone_number, format: {with: PHONE_NUMBER_FORMAT ,message: "手机号必须为11位数字"},
                        uniqueness: {case_sensitive: false ,message: "手机号已被使用"}
                        
    validates :user_role, presence: true,
                        exclusion: { in: [:student,:teacher,:admin], message: "无法识别的用户角色"}
                        
    # attributes
    has_secure_password
    attr_accessor :remember_token
    
    # association
    has_many :creatings, class_name: :Knowledge, inverse_of: :creator
    has_many :notifications, dependent: :destroy
    
    has_many :course_user_associations, dependent: :destroy
    has_many :selected_courses, through: :course_user_associations, source: :course
    
    has_many :focus_knowledge_associations, dependent: :destroy
    has_many :focus_contents, through: :focus_knowledge_associations, source: :knowledge
    
    has_many :like_knowledge_associations, class_name: :GoodAssociation, dependent: :destroy
    has_many :like_knowledges, through: :like_knowledge_associations, source: :knowledge
    
    has_many :unlike_knowledge_associations, class_name: :BadAssociation, dependent: :destroy
    has_many :unlike_knowledges, through: :unlike_knowledge_associations, source: :knowledge

    has_many :user_keyword_associations, dependent: :destroy
    has_many :focus_keywords, through: :user_keyword_associations, source: :keyword
    
    has_many :following_associations, class_name: :UserFollowAssociation,
                                        dependent: :destroy,
                                        foreign_key: :following_id
    has_many :followed_associations, class_name: :UserFollowAssociation,
                                        dependent: :destroy,
                                        foreign_key: :followed_id
    has_many :followings, through: :following_associations, source: :followed, inverse_of: :followeds
    has_many :followeds, through: :followed_associations, source: :following, inverse_of: :followings

    has_one :user_config    
    
    # class methods
    def User.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                    BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
    end
    
    def User.new_token
        SecureRandom.urlsafe_base64
    end
    
    # instance methods
    def remember
        self.remember_token = User.new_token
        update_attribute(:remember_digest, User.digest(remember_token))
    end
    
    def forget
        self.remember_token = nil
        update_attribute(:remember_digest, nil)
    end
    
    def remembered?(remember_token)
        return unless remember_digest
        BCrypt::Password.new(remember_digest).is_password?(remember_token)
    end
    
    def update_check_time
       self.update_attribute(:last_check_time, Time.now) 
    end
    
    def after_initial
        create_user_config unless !user_config.nil?
        update_attributes(sex: "保密", grade: "空", user_class: "空",
                            department: "空", speciality: "空",
                            self_introduce: "这个人很懒，什么都没有留下")
    end
    
    def before_save
       self.email.downcase!
       if d = Department.find_by(name: self.department)
            self.department_id = d.id
            if s = Speciality.find_by(name: self.speciality)
                self.speciality_id = s.id
            end
       end
    end
    
    # 返回未检查的notification的数目
    def uncheck_notifications_count
        notifications.where("notifications.created_at>?",
                      self.last_check_time).count
    end
    
    # 返回用户的notification列表，同时更新检查时间，并提供分页功能。
    def get_notify! page=1, per_page=10, notify_type="all"
        type = notify_type_group(notify_type)
        self.update_check_time
        self.notifications.where(notify_type: type).order(created_at: :desc).paginate(page: page,per_page: per_page)
    end
    
      # 为用户创造一个notification的辅助方法
    def generate_notification!(options={})
        if options[:notify_entity]
          notify_entity = options[:notify_entity]
          options.delete(:notify_entity)
          notification = self.notifications.build(options)
          notification.notify_entity_id = notify_entity.id
          notification.save
        elsif options[:notify_entity_id]
          notification = self.notifications.create(options)
        end
    end
    
    def update_notification
        course_config = self.course_config
        time = self.last_check_time || Time.now - 1.day
        
        # check courses user has followed
        self.selected_courses.each do |course|
          knowledges_need_notify = course.knowledges.where(type: course_config.keys, check_state: 1).where(
                                  "knowledges.created_at>?",time)
                  
          knowledges_need_notify.each do |knowledge|
            generate_notification!(notify_entity: course,
                                  notify_type: NOTIFY_TYPE_NEW,
                                  entity_type: ENTITY_TYPE_COURSE,
                                  with_entity_id: knowledge.id,
                                  with_entity_type: knowledge.type)
          end
        end
        
        # check knowledges user has followed
        knowledges_need_notify = self.focus_contents.where(check_state: 1).where("knowledges.updated_at>?",time)
        knowledges_need_notify.each do |knowledge|
          generate_notification!(notify_entity: knowledge,
                                notify_type: NOTIFY_TYPE_UPDATE,
                                entity_type: knowledge.type)
        end
        
        # check new replies for user's creation and following quesion
        knowledges_need_notify = self.focus_contents.where(type: ENTITY_TYPE_QUESTION, check_state: 1).where("knowledges.last_reply_at>?", time)
        knowledges_need_notify.each do |knowledge|
          knowledge.replies.where("knowledges.created_at>?",time).each do |reply|
            generate_notification!(notify_entity: knowledge,
                                  notify_type: NOTIFY_TYPE_ANSWER,
                                  entity_type: knowledge.type,
                                  initiator_id: reply.user_id,
                                  with_entity_id: reply.id,
                                  with_entity_type: reply.type)
          end
        end
        knowledges_need_notify = self.creatings.
                                  where("knowledges.last_reply_at>? and knowledges.last_reply_at-knowledges.created_at<1", time)
        knowledges_need_notify.each do |knowledge|
          knowledge.replies.where("knowledges.created_at>?",time).each do |reply|
            generate_notification!(notify_entity: knowledge,
                                  notify_type: NOTIFY_TYPE_REPLY,
                                  entity_type: knowledge.type,
                                  initiator_id: reply.user_id,
                                  with_entity_id: reply.id,
                                  with_entity_type: reply.type)
          end
        end
        
        #check focus users new creating,no include answer or relpy, need to optimize:
        f_user_ids = self.following_ids
        knowledges_need_notify = Knowledge.where("knowledges.user_id IN (?) and knowledges.created_at>? and knowledges.type<>? and check_state=1",f_user_ids, time, "Reply")
        knowledges_need_notify.each do |knowledge|
          generate_notification!(notify_entity: knowledge,
                                notify_type: NOTIFY_TYPE_FOCUS_USER_NEW,
                                entity_type: knowledge.type,
                                initiator_id: knowledge.user_id)
        end
        
        #check if there new followeds
        associations = self.followed_associations.where("user_follow_associations.created_at>?", time)
        associations.each do |association|
          generate_notification!(notify_entity_id: association.following_id,
                                 notify_type: NOTIFY_TYPE_NEW_FOLLOWED,
                                 entity_type: ENTITY_TYPE_USER)
        end
        
    end
    
    # get user's config, if it is nil, set all option to default.
    def course_config
        if self.user_config
          if self.user_config.courses_notification_config
            config = JSON::parse(self.user_config.courses_notification_config)
          else
            config = {Resource: true,
                            Blog: true,
                            Question: true}
          end
        else
          config = {Resource: true,
                          Blog: true,
                          Question: true}
        end
        # find all knowledge in user selected course and in user_config
        config.delete_if {|key, var| var.nil?||var==false}
    end
    
    def to_path
      "/users/#{self.id}"
    end
    
    
end
