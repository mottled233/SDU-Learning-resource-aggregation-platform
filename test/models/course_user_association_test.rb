require 'test_helper'

class CourseUserAssociationTest < ActiveSupport::TestCase
  def setup
    @user = users(:student1)
    @user.password = "123456"
    @course = courses(:rails)
    @association = course_user_associations(:one)
  end
  
  test "should be access by user" do
    assert_not @user.course_user_associations.empty?
    assert_equal @user.course_user_associations[0].id, @association.id
    assert_equal @user.selected_courses[0].id, @course.id
  end
  
  test "should be access by course" do
    assert_not @course.course_user_associations.empty?
    assert_equal @course.users[0].id, @user.id
    assert_equal @course.course_user_associations[0].id, @association.id
  end
    
  test "should not be duplicate" do
    association = CourseUserAssociation.new(course_id: @course.id, user_id: @user.id)
    assert_not association.save
  end
end
