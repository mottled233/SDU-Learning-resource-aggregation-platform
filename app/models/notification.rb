class Notification < ApplicationRecord
  include NotificationsHelper
  
  # callback
  after_create :after_initial
  
  # validates
  validates :user_id, presence: true
  validates :entity_type, presence: true
  validates :notify_entity_id, presence: true
  validates :notify_type, presence: true
  
  # associations
  belongs_to :user
  
  # instance method
  def after_initial
    if user.notifications.count >= NOTIFY_MAX_RESERVE
        user.notifications[0].destroy
    end
  end
  
  def norrow_notify_entity
    Notification.norrow_entity notify_entity_id, entity_type
  end
  
  def norrow_with_entity
    Notification.norrow_entity with_entity_id, with_entity_type
  end
  
  def to_text
    entity = norrow_notify_entity
    with_entity = norrow_with_entity
    
    return "该提醒对应资源已被删除" unless entity && with_entity 
    
    case notify_type
    when NOTIFY_TYPE_NEW
      %Q{您关注的课程"#{entity.course_name}"更新了新的资源"#{with_entity.title}"。}
    when NOTIFY_TYPE_ANSWER
      %Q{用户"#{User.find(initiator_id).nickname}"回答了您关注的问题"#{entity.title}"。}
    when NOTIFY_TYPE_UPDATE
      %Q{您关注的资源"#{entity.title}"更新了。}
    when NOTIFY_TYPE_REPLY
      if entity.type==ENTITY_TYPE_REPLY
        str = "回复"
      else
        str = entity.title
      end
      %Q{用户"#{User.find(initiator_id).nickname}"回复了您的发表的"#{str}"。}
    else
      %Q{通知类型：#{notify_type}。}
    end
  end
  
  # class methods
  def Notification.norrow_entity(id, type)
    if id && type
      begin
        case type
          when ENTITY_TYPE_COURSE
            Course.find(id)
          when ENTITY_TYPE_QUESTION
            Question.find(id)
          when ENTITY_TYPE_BLOG
            Blog.find(id)
          when ENTITY_TYPE_REPLY
            Reply.find(id)
          when ENTITY_TYPE_RESOURCE
            Resource.find(id)
        end
      rescue
        false
      end
        
    end
  end
  
  # need to split and optimize
  
  
  
  
  
end
