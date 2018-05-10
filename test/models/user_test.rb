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
  end
  
  test "should detect department error" do
    @student_user.department = "软件学院"
    @student_user.valid?
    assert @student_user.errors[:department].empty?
    @student_user.department = '没有学院'
    @student_user.valid?
    assert_not @student_user.errors[:department].empty?
  end
  
  test "should detect specialities error" do
    @student_user.department = "软件学院"
    @student_user.speciality = "软件工程"
    @student_user.valid?
    assert @student_user.errors[:speciality].empty?
    @student_user.department = "数学院"
    @student_user.speciality = "软件工程"
    @student_user.valid?
    assert_not @student_user.errors[:speciality].empty?
    @student_user.speciality = ""
    @student_user.valid?
    assert @student_user.errors[:speciality].empty?
  end
  
  test "should auto set department_id" do
    @student_user.department_id = nil
    @student_user.speciality_id = nil
    @student_user.department = "软件学院"
    @student_user.speciality = "软件工程"
    assert @student_user.save!
    assert_equal @student_user.department_id, Department.find_by(name: @student_user.department).id
    assert_equal @student_user.speciality_id, Speciality.find_by(name: @student_user.speciality).id
    
  end
end
