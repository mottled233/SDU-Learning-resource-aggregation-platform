require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:student1)
    @user.password = "123456"
  end
  
  test "should get user_page" do
    get user_path(@user)
    assert_response :success
    assert_template 'users/show'
  end
  
end
