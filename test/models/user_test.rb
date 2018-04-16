require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @student_user = users(:student1)
    @student_user.password = "123456"
  end
  
  def recover
    @student_user = users(:student1)
  end
  
  test "should be valid" do
    @student_user.valid?
    puts @student_user.errors.full_messages
    assert @student_user.valid?
  end
end
