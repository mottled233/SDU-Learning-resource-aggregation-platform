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
    assert log_in?
    
  end
  
  test "login user with incorrect information" do
    get login_path
    assert_template 'sessions/new'
    post login_path params: {session: {username: @user.username, password: "wrong password"}}
    assert_redirected_to login_path
    follow_redirect!
    assert_not flash.empty?
  end
end
