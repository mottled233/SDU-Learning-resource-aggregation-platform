class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  include UsersHelper
  include NotificationsHelper
  add_flash_types :warning, :success, :danger

end
