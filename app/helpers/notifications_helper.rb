
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
    

    
    
  def to_html notification
    entity = notification.norrow_notify_entity
    
    case notification.notify_type
    when NOTIFY_TYPE_NEW
      type_new_html
    when NOTIFY_TYPE_ANSWER
      type_answer_html notification
    when NOTIFY_TYPE_UPDATE
      type_update_html notification
    when NOTIFY_TYPE_REPLY
      if entity.type==ENTITY_TYPE_REPLY
        str = "回复"
      else
        str = entity.title
      end
      %Q{用户"#{User.find(notification.initiator_id).nickname}"回复了您的发表的"#{str}"。}
    else
      %Q{通知类型：#{notify_type}。}
    end
  end
  
  def type_new_html notification
    entity = notification.norrow_notify_entity
    with_entity = notification.norrow_with_entity
    content_tag :div do
      concat(
        content_tag(:p, style:"font-size:1.4em") do
          concat "您关注的课程"
          concat(link_to "#{entity.name}", entity.to_path, class:"underline")
          concat " 更新了新的资源： "
          concat(link_to "#{with_entity.title}", with_entity.to_path, class:"underline")
        end
      )
      concat(
        content_tag(:p,"#{time_to_chinese(time_ago_in_words(notification.created_at))}前", class:"grey", style:"text-align:right")
      )
    end
  end
  
  def type_answer_html notification
    entity = notification.norrow_notify_entity
    content_tag :div do
      concat(
        content_tag(:p, style:"font-size:1.4em") do
          concat "用户 "
          concat(link_to "#{User.find(notification.initiator_id).nickname}", user_path(notification.initiator_id), class:"underline")
          concat " 回答了您关注的问题 "
          concat(link_to "#{entity.title}", question_path(entity.id), class:"underline")
          concat ":"
        end
      )
      concat(
        content_tag(:p, style:"font-size:1.2em;padding-left:50px;color:grey") do
          concat "“"
          content = entity.content
          content = content[0,50] + "..." if entity.content.length>50
          concat content
          concat "”"
        end
      )
      concat(
        content_tag(:p,"#{time_to_chinese(time_ago_in_words(notification.created_at))}前", class:"grey", style:"text-align:right")
      )
    end
  end
  
  def type_update_html notification
    entity = notification.norrow_notify_entity
    content_tag :div do
      concat(
        content_tag(:p, style:"font-size:1.4em") do
          concat "您关注的资源"
          concat(link_to "#{entity.title}", entity.to_path, class:"underline")
          concat " 更新了。"
        end
      )
      concat(
        content_tag(:p,"#{time_to_chinese(time_ago_in_words(notification.created_at))}前", class:"grey", style:"text-align:right")
      )
    end
  end
  
    
    
    

end
