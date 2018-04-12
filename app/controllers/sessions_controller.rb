class SessionsController < ApplicationController
  def new
    
  end
  
  def create
    user = User.find_by(username: params[:session][:username])
    if user && user.authenticate(params[:session][:password])
      log_in user
      if params[:session][:remember_me] == 1
        remember user
      else
        forget user
      end
      redirect_back_or(user_path(user))

    else
      flash.now[:danger] = '用户名或密码错误，请核对后输入'
      render 'new'
    end
  end
  
  def destroy
    log_out
    redirect_to home_path
  end
end
