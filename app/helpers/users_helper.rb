module UsersHelper
    # constants
    USER_ROLE_ADMIN = "admin"
    USER_ROLE_STUDENT = "student"
    USER_ROLE_TEACHER = "teacher"
    
    # methods
    def gravatar_for(user, options = { size: 80, style:""})
        gravatar_url = "https://secure.gravatar.com/avatar/#{user.username}?s=#{options[:size]}"
        image_tag(gravatar_url, alt: user.username, class:"gravatar", style: options[:style])
    end
    
    
    def confirm_logged_in
      unless log_in?
        store_location
        flash[:danger] = "请先登录。"
        redirect_to login_path
      end
    end
    
    
    def confirm_access
      id = params[:id] || params[:user_id]
      unless log_in? && id == current_user.id.to_s
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
    
    def confirm_is_teacher
      unless current_user.user_role == "teacher"
        flash[:danger] = "您没有权限执行此操作。"
        redirect_to home_path
      end
    end
    
end
