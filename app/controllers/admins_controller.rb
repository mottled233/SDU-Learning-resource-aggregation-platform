class AdminsController < ApplicationController
    before_action :confirm_is_admin, only: [:destroy]
    

    
    def own_space
    end
    
    def row_nav
    end
    
    def show
        # @user = User.find(params[:id])
    end
    
    def ajaxtest
        respond_to do |format|
        format.js
        format.html
        end
    end
end
