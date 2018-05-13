class NotificationsController < ApplicationController
    include NotificationsHelper
    before_action :confirm_access, only: [:index]
    
    def index
        @user = current_user
        @notifications = @user.update_notification
        
        respond_to do |format| 
            format.html
            format.js
        end 
        
    end
    
end
