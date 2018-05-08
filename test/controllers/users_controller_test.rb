require 'test_helper'
require 'json'
class UsersControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:student1)
    @user.password = "123456"
    @user.save
    @user.user_config = user_configs(:one)
  end
  
  test "should update config" do
    assert_equal @user.id,user_configs(:one).user_id
    post update_user_config_path(@user), 
                      params: { user_config: { course_question: 1,
                                                course_blog: 1,
                                                knowledge_reply: 1} }
                                                
    dict = JSON::parse(@user.user_config.reload.courses_notification_config)
    assert_redirected_to edit_user_config_path(@user)
    assert_not_empty flash[:success]
    
    assert dict["Question"]
    assert dict["Blog"]
    assert_not dict["Resource"]
    dict = JSON::parse(@user.user_config.knowledges_notification_config)
    assert dict["Reply"]
    

  end
  
end
