require 'test_helper'

class DepartmentsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get departments_new_url
    assert_response :success
  end

  test "should get show" do
    get departments_show_url
    assert_response :success
  end

  test "should get create" do
    get departments_create_url
    assert_response :success
  end

  test "should get edit" do
    get departments_edit_url
    assert_response :success
  end

  test "should get update" do
    get departments_update_url
    assert_response :success
  end

end
