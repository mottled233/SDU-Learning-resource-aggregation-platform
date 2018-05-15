class NotificationsController < ApplicationController
    include NotificationsHelper
    before_action :confirm_access, only: [:index]
    
    def index
        @user = current_user
        @user.update_notification
        page = params[:page] || 1
        per_page = params[:per_page] || 20
        @notifications = @user.get_notify! page, per_page, params[:notify_type]
        
        
        respond_to do |format| 
            format.html
            format.js
        end 
        
    end
    
end
