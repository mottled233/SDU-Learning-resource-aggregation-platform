
module NotificationsHelper
  # constants
  ENTITY_TYPE_COURSE = "Course"
  ENTITY_TYPE_QUESTION = "Question"
  ENTITY_TYPE_BLOG = "Blog"
  ENTITY_TYPE_RESOURCE = "Resource"
  ENTITY_TYPE_REPLY = "Reply"
  
  NOTIFY_TYPE_GOOD = "good"
  NOTIFY_TYPE_BAD = "bad"
  NOTIFY_TYPE_DELETED = "deleted"
  NOTIFY_TYPE_REPLY = "reply"
  NOTIFY_TYPE_ANSWER = "answer"
  NOTIFY_TYPE_BOUTIQUED = "boutiqued"
  NOTIFY_TYPE_PASS = "pass"
  NOTIFY_TYPE_REFUSE ="refuse"
  NOTIFY_TYPE_UPDATE = "update"
  NOTIFY_TYPE_NEW = "new"
  
  NOTIFY_MAX_RESERVE = 50
    
    # functions
    # index
      # - generate_notification!(user, notify_entity, options={})
      # - get_notifications!(user)
      # - norrow_notify_entity(notification)
      # - norrow_with_entity(notification)
      # - norrow_entity(id, type)
      # - to_text(notification)
      # - check_notification(user)
    # should be ajax in controller in iter2
    
    def notify_type_group(notify_type)
      case notify_type.to_s
      when "focus_contents"
          [NOTIFY_TYPE_UPDATE, NOTIFY_TYPE_ANSWER]
      when "my"
          [NOTIFY_TYPE_REPLY, NOTIFY_TYPE_BOUTIQUED, NOTIFY_TYPE_GOOD,
            NOTIFY_TYPE_BAD, NOTIFY_TYPE_PASS, NOTIFY_TYPE_REFUSE]
      else
          [NOTIFY_TYPE_GOOD, NOTIFY_TYPE_BAD, NOTIFY_TYPE_DELETED,
            NOTIFY_TYPE_REPLY, NOTIFY_TYPE_ANSWER, NOTIFY_TYPE_BOUTIQUED,
            NOTIFY_TYPE_PASS, NOTIFY_TYPE_REFUSE, NOTIFY_TYPE_UPDATE, NOTIFY_TYPE_NEW]
      end
    end

    
    
    
    
    
    
    
    

end
