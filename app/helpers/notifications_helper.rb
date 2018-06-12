
module NotificationsHelper
  # constants
  ENTITY_TYPE_COURSE = "Course"
  ENTITY_TYPE_QUESTION = "Question"
  ENTITY_TYPE_BLOG = "Blog"
  ENTITY_TYPE_RESOURCE = "Resource"
  ENTITY_TYPE_REPLY = "Reply"
  ENTITY_TYPE_USER = "User"
  
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
  NOTIFY_TYPE_FOCUS_USER_NEW = "focus_user_new"
  NOTIFY_TYPE_NEW_FOLLOWED = "new_followed"
  
  NOTIFY_MAX_RESERVE = 50
    
  def notify_type_group(notify_type)
    case notify_type.to_s
    when "focus_contents"
        [NOTIFY_TYPE_UPDATE, NOTIFY_TYPE_ANSWER, NOTIFY_TYPE_FOCUS_USER_NEW]
    when "my"
        [NOTIFY_TYPE_REPLY, NOTIFY_TYPE_BOUTIQUED, NOTIFY_TYPE_GOOD,
          NOTIFY_TYPE_BAD, NOTIFY_TYPE_PASS, NOTIFY_TYPE_REFUSE, NOTIFY_TYPE_NEW_FOLLOWED]
    else
        [NOTIFY_TYPE_GOOD, NOTIFY_TYPE_BAD, NOTIFY_TYPE_DELETED,
          NOTIFY_TYPE_REPLY, NOTIFY_TYPE_ANSWER, NOTIFY_TYPE_BOUTIQUED,
          NOTIFY_TYPE_PASS, NOTIFY_TYPE_REFUSE, NOTIFY_TYPE_UPDATE,
          NOTIFY_TYPE_NEW, NOTIFY_TYPE_FOCUS_USER_NEW, NOTIFY_TYPE_NEW_FOLLOWED]
    end
  end
    

    
    
  def to_html notification
    @entity = notification.norrow_notify_entity
    @with_entity = notification.norrow_with_entity
    unless (@entity && @with_entity)
      return (content_tag :div do
        concat "该提醒对应知识已经无效"
        notify_time notification
      end)
    end
    content_tag :div do
      case notification.notify_type
      when NOTIFY_TYPE_NEW
        type_new_html notification
      when NOTIFY_TYPE_ANSWER
        type_answer_html notification
      when NOTIFY_TYPE_UPDATE
        type_update_html notification
      when NOTIFY_TYPE_REPLY
        type_reply_html notification
      when NOTIFY_TYPE_FOCUS_USER_NEW
        type_focus_user_new_html notification
      when NOTIFY_TYPE_NEW_FOLLOWED
        type_new_followed_html notification
      else
        concat(%Q{通知类型：#{notify_type}。})
      end
      
      notify_time notification
    end
    
  end
  
  def type_new_html notification
    entity = notification.norrow_notify_entity
    with_entity = notification.norrow_with_entity
    
    concat(
      content_tag(:p, style:"font-size:1.4em") do
        concat "您关注的课程"
        concat(link_to "《#{entity.name}》", entity.to_path, class:"underline")
        concat " 更新了新的资源： "
        concat(link_to "《#{with_entity.title}》", with_entity.to_path, class:"underline")
      end
    )
      
  end
  
  def type_answer_html notification
    entity = notification.norrow_notify_entity
    
    concat(
      content_tag(:p, style:"font-size:1.4em") do
        concat "用户 "
        concat(link_to "#{User.find(notification.initiator_id).nickname}", user_path(notification.initiator_id), class:"underline")
        concat " 回答了您关注的问题 "
        concat(link_to "《#{entity.title}》", question_path(entity.id), class:"underline")
        concat ":"
      end
    )
    concat(
      content_tag(:p, style:"font-size:1.2em;padding-left:50px;color:grey") do
        concat "“"
        content = entity.knowledge_digest
        concat content
        concat "”"
      end
    )
    
  end
  
  def type_update_html notification
    entity = notification.norrow_notify_entity
    
    concat(
      content_tag(:p, style:"font-size:1.4em") do
        concat "您关注的资源 "
        concat(link_to "《#{entity.title}》", entity.to_path, class:"underline")
        concat " 更新了。"
      end
    )
      
  end
  
  def type_reply_html notification
    entity = notification.norrow_notify_entity
    with_entity = notification.norrow_with_entity

    concat(
      content_tag(:p, style:"font-size:1.4em") do
        concat "用户 "
        user = User.find(notification.initiator_id)
        concat(link_to "#{user.nickname}", user_path(notification.initiator_id), class:"underline")
        if entity.type==ENTITY_TYPE_REPLY
          concat " 回复了您在"
          concat(link_to "《#{entity.ancestor.title}》", entity.to_path, class:"underline")
          concat "下的回复"
        else
          concat " 回复了您发表的"
          concat(link_to "《#{entity.title}》", entity.to_path, class:"underline")
        end
        concat ":"
      end
    )
    concat(
      content_tag(:p, style:"font-size:1.2em;padding-left:50px;color:grey") do
        concat "“"
        content = with_entity.knowledge_digest
        concat content
        concat "”"
      end
    )
  end
  
  def type_focus_user_new_html notification
    entity = notification.norrow_notify_entity
    user = User.find(notification.initiator_id)
    
    concat(
      content_tag(:p, style:"font-size:1.4em") do
        concat "您关注的用户 "
        concat(link_to "#{user.nickname}", user.to_path, class:"underline")
        concat " 发布了新的资源： "
        concat(link_to "《#{entity.title}》", entity.to_path, class:"underline")
      end
    )
    
  end
  
  def type_new_followed_html notification
    entity = notification.norrow_notify_entity
    concat(
      content_tag(:p, style:"font-size:1.4em") do
        concat "用户 "
        concat(link_to "#{entity.nickname}", entity.to_path, class:"underline")
        concat " 关注了您。"
      end
    )
  end
  
  def notify_time notification
    concat content_tag(:p,"#{time_to_chinese(time_ago_in_words(notification.created_at))}前", class:"grey", style:"text-align:right")
  end
    
    

end
