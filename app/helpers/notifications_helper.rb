module NotificationsHelper
    # constants
    # how to use: NotificationsHelper::ENTITY_TYPE_COURSE
    ENTITY_TYPE_COURSE = "course"
    ENTITY_TYPE_QUESTION = "question"
    ENTITY_TYPE_BLOG = "blog"
    ENTITY_TYPE_RESOURCE = "resource"
    ENTITY_TYPE_REPLY = "reply"
    
    NOTIFY_TYPE_GOOD = "good"
    NOTIFY_TYPE_BAD = "bad"
    NOTIFY_TYPE_DELETED = "deleted"
    NOTIFY_TYPE_REPLY = "reply"
    NOTIFY_TYPE_BOUTIQUED = "boutiqued"
    NOTIFY_TYPE_PASS = "pass"
    NOTIFY_TYPE_REFUSE ="refuse"
    NOTIFY_TYPE_UPDATE = "update"
    NOTIFY_TYPE_NEW = "new"
    
    NOTIFY_MAX_RESERVE = 50
    
    # functions
    def generate_notification!(user, notify_entity, options={})
        if user && notify_entity
            notification = user.notifications.build(options)
            notification.notify_entity_id = notify_entity.id
            
            if user.notifications.count >= NOTIFY_MAX_RESERVE
                # wating for test
                user.notifications[0].destroy
            end
            
            notification.save
        end
    end
    
    def generate_notification_for_entity(notify_entity, options={})
      if notify_entity
        users = notify_entity.get_followers
        users.each do |user|
            notification = user.notifications.build(options)
            notification.notify_entity_id = notify_entity.id
            if user.notifications.count >= NOTIFY_MAX_RESERVE
                # wating for test
                user.notifications[0].destroy
            end
            notification.save
        end
      end
    end
    
    def get_and_clear_notifications!(user)
        if user
            list = user.notifications
            user.notifications.clear
            list
        end
    end
    
    def norrow_notify_entity(notification)
       if notification
          case notification.entity_type
            when ENTITY_TYPE_COURSE
              Course.find(notification.notify_entity_id)
            when ENTITY_TYPE_QUESTION
              Question.find(notification.notify_entity_id)
            when ENTITY_TYPE_BLOG
              BLOG.find(notification.notify_entity_id)
            when ENTITY_TYPE_REPLY
              REPLY.find(notification.notify_entity_id)
            when ENTITY_TYPE_RESOURCE
              RESOURCE.find(notification.notify_entity_id)
          end
       end
    end
    
end
