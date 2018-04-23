require 'test_helper'

class CoursePagesControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get course_pages_home_url
    assert_response :success
  end

  test "should get blog" do
    get course_pages_blog_url
    assert_response :success
  end

  test "should get question" do
    get course_pages_question_url
    assert_response :success
  end

  test "should get resource" do
    get course_pages_resource_url
    assert_response :success
  end

end
