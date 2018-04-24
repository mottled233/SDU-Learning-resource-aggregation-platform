require 'test_helper'

class NotificationTest < ActiveSupport::TestCase
  def setup
    @user = users(:student1)
    @user.password = "123456"
    
    
  end
end
