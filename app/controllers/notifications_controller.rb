class NotificationsController < ApplicationController
    include NotificationsHelper
    
    def index
        
        @notifications = check_notification(current_user)
        
        respond_to do |format| 
            format.html
            format.js
        end 
    end
    
end
