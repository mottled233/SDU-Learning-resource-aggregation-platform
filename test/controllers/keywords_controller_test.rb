require 'test_helper'

class KeywordsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get keywords_new_url
    assert_response :success
  end

end
