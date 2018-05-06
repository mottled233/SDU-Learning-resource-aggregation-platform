require 'test_helper'

class NotificationTest < ActiveSupport::TestCase
  
  include NotificationsHelper
  
  def setup
    @user = users(:student1)
    @user.password = "123456"
    @question = knowledges(:questions1)
    @question.creator = users(:student1)
    @course = courses(:rails)
  end
  
  test "could generate notification" do
    count = @user.notifications.count
    
    generate_notification! @user, @question, entity_type: ENTITY_TYPE_QUESTION,
                          notify_type: NOTIFY_TYPE_UPDATE
                          
    assert_equal count+1, @user.notifications.count
    
  end  
  
  test "user should detect knowledge update" do
    count = @user.notifications.count
    @user.last_check_time = Time.now
    assert @user.save
    @question.updated_at = Time.now + 1.hour
    @question.title = "test"
    assert @question.save
    check_notification @user
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
end
