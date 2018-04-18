require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(username: "test_student", nickname: "小刚", password: "123456", email: "foo@bar.com", phone_number: "12345678901", user_role: "student")
    
    @student_user = users(:student1)
    @student_user.password = "123456"
  end
  
  def recover
    @student_user = users(:student1)
    @student_user.password = "123456"
  end
  
  test "should be valid" do
    assert @student_user.valid?
    @user.valid?
    puts @user.errors.full_messages
  end
end
