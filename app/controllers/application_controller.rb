class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  include ApplicationHelper
  include UsersHelper
  include NotificationsHelper
  add_flash_types :warning, :success, :danger
  
  before_action :get_notify
  
  def get_notify
    return if params[:no_notification_check].to_s=='true'
    return unless log_in?
    user = current_user
    
    begin
      user.update_notification
      @uncheck_notifications = user.uncheck_notifications_count
      @latest_notifications = user.get_notify!
    rescue ActiveRecord::StatementInvalid => e
      puts "data_lock"
      puts e.message
    end
    
  end

end
