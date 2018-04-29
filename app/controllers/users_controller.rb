class UsersController < ApplicationController
  before_action :confirm_logged_in, only: [:index, :edit, :update]
  before_action :confirm_access, only: [:edit, :update]
  before_action :confirm_is_admin, only: [:destroy]
  
  def new
    @user = User.new
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def create
    @user = User.new(user_param)
    if @user.save
      @user.create_user_config
      flash[:success] = "欢迎, #{@user.name}!"
      log_in @user
      remember @user
      
      redirect_to user_url(@user)
    else
      render 'new'
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_param)
      flash[:success] = "success to update user information!"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  def index
    
  end
  
  def destroy
    
  end
  
  private
    def user_param
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :phone_number, :user_role, :nickname)
    end
    
    
end
