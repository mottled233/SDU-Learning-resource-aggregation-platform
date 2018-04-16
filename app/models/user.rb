class User < ApplicationRecord
    # constants
    NAME_FORMAT = /\A[\w]+\z/
    NICK_FORMAT = /\A[\u4e00-\u9fa5a-zA-Z0-9]+\Z/
    EMAIL_FORMAT = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    PHONE_NUMBER_FORMAT = /\A[0-9]{11}\z/
    
    # callback
    before_save {self.email.downcase!}
    
    # validates
    validates :username, presence: {message: "用户名不能为空"},
                        length: {in: 3..20, message: "用户名长度必须为1-20字之间"},
                        format: {with: NAME_FORMAT, message: "用户名只能含英文字母，数字，下划线"},
                        uniqueness: {message: "用户名已被使用"}
    
    validates :nickname, presence: {message: "昵称不能为空"},
                        length: {in: 1..20, message: "昵称长度必须为1-20字之间"},
                        format: {with: NICK_FORMAT, message: "昵称含非法字符"},
                        uniqueness: {message: "昵称已被使用"}
                        
    validates :password, presence: {message: "密码不能为空"},
                        length: {in: 6..20, message: "密码必须为6-20位字符"}
                        
    validates :email, presence: {message: "电子邮件不能为空"},
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
    
end
