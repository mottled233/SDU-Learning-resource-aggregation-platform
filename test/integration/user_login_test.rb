require 'test_helper'

class UserLoginTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:student1)
    @user.password = "123456"
    @user_form = {session: {username: @user.username, password: @user.password}}
    
  end
  
  test "login user with correct information" do
    get login_path
    assert_template 'sessions/new'
    post login_path params: @user_form
    assert_template 'users/show'
    assert_not flash.empty?
  end
  
end
