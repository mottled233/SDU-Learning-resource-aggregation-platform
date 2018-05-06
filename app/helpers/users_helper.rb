module UsersHelper
    # constants
    USER_ROLE_ADMIN = "admin"
    USER_ROLE_STUDENT = "student"
    USER_ROLE_TEACHER = "teacher"
    
    # methods
    def gravatar_for(user, options = { size: 80})
        gravatar_id = Digest::MD5::hexdigest((user.email).downcase)
        gravatar_url = "https://secure.gravatar.com/avatar/#{user.username}?s=#{options[:size]}"
        image_tag(gravatar_url, alt: user.username, class:"gravatar")
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
      unless current_user.user_role == "admin"
        flash[:danger] = "您没有权限执行此操作。"
        redirect_to home_path
      end
    end
    
end