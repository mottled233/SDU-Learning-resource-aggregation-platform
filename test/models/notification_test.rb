require 'test_helper'

class NotificationTest < ActiveSupport::TestCase
  
  include NotificationsHelper
  
  def setup
    @user = users(:student1)
    @user.password = "123456"
    @question = knowledges(:questions1)
    @question.creator = users(:student1)
    @question.update_attribute(:created_at, Time.now-1.day)
    @course = courses(:rails)
  end
  
  test "could generate notification" do
    count = @user.notifications.count
    
    generate_notification! @user, @question, entity_type: ENTITY_TYPE_QUESTION,
                          notify_type: NOTIFY_TYPE_UPDATE
                          
    assert_equal count+1, @user.notifications.count
    
  end  
    
  test "should not overflow" do
    count = NOTIFY_MAX_RESERVE+1
    count.times do
          generate_notification! @user, @question, entity_type: ENTITY_TYPE_QUESTION,
                          notify_type: NOTIFY_TYPE_UPDATE
    end                
    assert_equal NOTIFY_MAX_RESERVE, @user.notifications.count
  end
  
  test "should detect knowledge update" do
    @user.notifications.clear
    count = @user.notifications.count
    @user.last_check_time = Time.now
    assert @user.save
    @question.updated_at = Time.now + 1.hour
    @question.title = "test"
    assert @question.save
    check_notification @user
    assert_equal count+1, @user.notifications.count
    @user.notifications.clear
  end
  
  test "should detect new reply" do
    @user.notifications.clear
    @user.update_attribute(:last_check_time, Time.now - 1.day)
    assert @question.replies.create(user_id: @user.id, title: :test_reply1, content: "hhh")
    check_notification @user
    assert_not_empty @user.notifications
  end
end
