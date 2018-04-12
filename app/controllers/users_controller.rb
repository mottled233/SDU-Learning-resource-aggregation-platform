class UsersController < ApplicationController
  before_action :confirm_logged_in, only: [:index, :edit, :update]
  before_action :confirm_access, only: [:edit, :update]
  before_action :confirm_is_admin, only: [:destroy]
  
  def new
    @user = User.new
  end
  
  def show
    
  end
  
  def create
    
  end
  
  def edit
      
  end
  
  def update
      
  end
  
  def index
      
  end
  
  def destroy
    
  end
  
  private
    def user_param
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :phone_number, :user_role, :nickname)
    end
    
    def confirm_logged_in
      unless log_in?
        store_location
        flash[:danger] = "您必须先登录才可以访问此页面!"
        redirect_to login_path
      end
    end
    
    def confirm_access
      unless params[:id] == current_user.id.to_s
        flash[:danger] = "您没有权限执行此操作。"
        redirect_to home_path
      end
    end
    
    def confirm_is_admin
      unless current_user.admin?
        flash[:danger] = "您没有权限执行此操作。"
        redirect_to home_path
      end
    end
    
    
end
