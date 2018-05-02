class AdminsController < ApplicationController
    before_action :confirm_logged_in, only: [:own_space, :edit, :update]

    before_action :confirm_is_admin, only: [:own_space, :edit, :update]
    

    
    def own_space
    end
    
    def row_nav
    end
    
    def edit
        @admin = current_user
# @admin = User.where("username=?","admin").first
    end
    
    def update
        @admin = User.find(params[:user][:id])
        
        confirm_id = @admin.authenticate(params[:user][:password_old])
        same_new_password = true
        # debugger
        if !params[:user][:password_new].nil? && !params[:user][:password_confirmed].nil? && params[:user][:password_new] != params[:user][:password_cofirmed]
            same_new_password = false
        end
        respond_to do |format|
            if confirm_id == false
                
                format.html { redirect_to admin_edit_path(@admin), notice: "认证失败" }
                
            elsif same_new_password == false
                format.html { redirect_to admin_edit_path(@admin), notice: "新密码不一致" }
                
            else
                up = user_param
                up[:password] = params[:user][:password_old]
                if @admin.update_attributes(up)
                #   flash[:success] = "success to update user information!"
                #   redirect_to 'admins/own_space'
                  format.html { redirect_to admin_edit_path(@admin), notice: "#{@admin.username}\'s information was successfully updated." }
                  
                else
                  format.html { redirect_to admin_edit_path(@admin), notice: "资料格式错误" }
                  
                end
            end
        end
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
    
private
    def user_param
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :phone_number, :user_role, :nickname)
    end
end
