class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  include UsersHelper
  include NotificationsHelper
  add_flash_types :warning, :success, :danger
  
  before_action :get_notify
  
  def get_notify
    return unless log_in?
    user = current_user
    user.update_notification
    @uncheck_notifications = user.uncheck_notifications_count
    @latest_notifications = user.get_notify!
    
  end

end
