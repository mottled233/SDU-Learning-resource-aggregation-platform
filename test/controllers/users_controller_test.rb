require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:student1)
    @user.password = "123456"
    @user.save
  end
  
  test "it should get user_page" do
    
    # get user_path(users(:student1))
    # assert_response :success
    # assert_template 'users/show'
  end
  
end
