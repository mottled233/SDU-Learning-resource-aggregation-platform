
module NotificationsHelper
    # constants
    # how to use: NotificationsHelper::ENTITY_TYPE_COURSE
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
    
    def get_notifications!(user)
        if user
            check_notification user
            count_new = user.notifications.where("notifications.created_at>?",
                                  user.last_check_time).count
            list = user.notifications.order(created_at: :desc).limit(10)
            user.update_check_time
            [list,count_new]
        end
    end
    
    def norrow_notify_entity(notification)
     if notification
        norrow_entity notification.notify_entity_id, notification.entity_type
     end
    end
    
    def norrow_with_entity(notification)
     if notification
        norrow_entity notification.with_entity_id, notification.with_entity_type
     end
    end
    
    def norrow_entity(id, type)
      if id && type
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
      end
    end
    
    def to_text(notification)
      entity = norrow_notify_entity notification
      with_entity = norrow_with_entity notification
      
      case notification.notify_type
      when NOTIFY_TYPE_NEW
        %Q{您关注的课程"#{entity.course_name}"更新了新的资源"#{with_entity.title}"。}
      when NOTIFY_TYPE_ANSWER
        %Q{用户"#{User.find(notification.initiator_id).nickname}"回答了您关注的问题"#{entity.title}"。}
      when NOTIFY_TYPE_UPDATE
        %Q{您关注的资源"#{entity.title}"更新了。}
      else
        %Q{通知类型：#{notify_type}。}
      end
    end
    
    # need to split and optimize
    def check_notification(user)
      return unless user
      
      # get user's config, if it is nil, set all option to default.
      if user.user_config
        if user.user_config.courses_notification_config
          course_config = JSON::parse(user.user_config.courses_notification_config)
        else
          course_config = {Resource: true,
                          Blog: true,
                          Question: true}
        end
      else
        course_config = {Resource: true,
                        Blog: true,
                        Question: true}
      end
      
      time = user.last_check_time || Time.now - 1.day
      
      # find all knowledge in user selected course and in user_config
      course_config = course_config.delete_if {|key, var| var.nil?||var==false}
      
      # check courses user has followed
      user.selected_courses.each do |course|
        knowledges_need_notify = course.knowledges.where(type: course_config.keys).where(
                                "knowledges.created_at>?",time)
                
        knowledges_need_notify.each do |knowledge|
          generate_notification!(user, course,
                                notify_type: NOTIFY_TYPE_NEW,
                                entity_type: ENTITY_TYPE_COURSE,
                                with_entity_id: knowledge.id,
                                with_entity_type: knowledge.type)
        end
      end
      
      # check knowledges user has followed
      knowledges_need_notify = user.focus_contents.where("knowledges.updated_at>?",time)
      knowledges_need_notify.each do |knowledge|
        generate_notification!(user, knowledge,
                              notify_type: NOTIFY_TYPE_UPDATE,
                              entity_type: knowledge.type)
      end
      
      # check new replies for user's creation and following quesion
      knowledges_need_notify = user.focus_contents.
                                where("knowledges.type=? and knowledges.last_reply_at>?",
                                      ENTITY_TYPE_QUESTION, time)
      knowledges_need_notify.each do |knowledge|
        knowledge.replies.where("knowledges.created_at>?",time).each do |reply|
          generate_notification!(user, knowledge,
                                notify_type: NOTIFY_TYPE_ANSWER,
                                entity_type: knowledge.type,
                                initiator_id: reply.user_id,
                                with_entity_id: reply.id,
                                with_entity_type: reply.type)
        end
      end
      knowledges_need_notify = user.creatings.
                                where("knowledges.last_reply_at>? and knowledges.last_reply_at-knowledges.created_at<1", time)
      knowledges_need_notify.each do |knowledge|
        knowledge.replies.where("knowledges.created_at>?",time).each do |reply|
          generate_notification!(user, knowledge,
                                notify_type: NOTIFY_TYPE_ANSWER,
                                entity_type: knowledge.type,
                                initiator_id: reply.user_id,
                                with_entity_id: reply.id,
                                with_entity_type: reply.type)
        end
      end
      
    end

end
