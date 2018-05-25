class TeachersController < ApplicationController

  before_action :confirm_logged_in
  before_action :confirm_is_teacher, only: [:teachers_space, :detials, :questions_manage, :blogs_manage, :resources_manage]
  

  before_action :confirm_is_admin, only: [:new, :index, :destroy, :newcourseass, :create_course_association, :deleteCourseTeacherAss, :create]
  
  def new
    @user = User.new
  end

  def index
    @teachers = User.where("user_role=?",:teacher)
  end
  
  def show
    @teacher = User.find(params[:id])
    @courses = @teacher.selected_courses
  end
  
  def destroy
      respond_to do |format|
        
        if User.delete(params[:id])
          format.html { redirect_to teachers_path, notice: "Teacher was successfully deleted." }
        else
          format.html { redirect_to teachers_path, notice: "Unknow Error"}
        end
        
      end
    
  end
  
  # def edit
  # end
  
  def newcourseass
    @teacher = User.find(params[:id])
    @course_teacher_association = @teacher.course_user_associations.new()
  end
  
  def create_course_association
    has_that_teacher = !User.where("id=? AND user_role=?",params[:course_user_association][:user], "teacher").empty?
    has_that_course = !Course.where("id=?",params[:course_user_association][:course_id]).empty?
    @redirect_path = params[:course_user_association][:badpath]
    if !has_that_course
      respond_to do |format|
        format.html { redirect_to @redirect_path, notice: "No that course." }
      end
    elsif !has_that_teacher
      respond_to do |format|
        format.html { redirect_to @redirect_path, notice: "No that teacher." }
      end  
    else
      @teacher = User.find(params[:course_user_association][:user])
      @course = Course.find(params[:course_user_association][:course_id])
      
      has_that_ass = !CourseUserAssociation.where("user_id = ? AND course_id =?" ,@teacher.id,@course.id).empty?
      @course_teacher_association = @teacher.course_user_associations.new
      @course_teacher_association.course = @course
  
      
      respond_to do |format|
        if has_that_ass
          format.html { redirect_to @redirect_path, notice: "Has That Teaching Association." }
        else
          if @course_teacher_association.save
            format.html { redirect_to params[:course_user_association][:goodpath], notice: "Teacher Course Association was successfully created." }
          else
            format.html { render :new }
          end
        end
      end
    end
  end
  
  def deleteCourseTeacherAss
    @teacher = @teacher = User.find(params[:id])
    @courseAss = @teacher.course_user_associations.where("course_id =?",params[:cid])
    CourseUserAssociation.delete(@courseAss.first.id)
    
    respond_to do |format|
      format.html { redirect_to teacher_path(@teacher), notice: 'TeachingAss was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def create
    @user = User.new(user_param)
    @user.user_role = USER_ROLE_TEACHER
    if @user.save
      @user.create_user_config
      flash[:success] = "创建成功, #{@user.username}!"
      # log_in @user
      # remember @user
      
      redirect_to teachers_path
    else
      render 'new'
    end
  end
  
  def teachers_space
    @teacher = User.find(params[:id])
    @courses = @teacher.selected_courses
    @user = @teacher
  end
  
  def detials
    @course = Course.find(params[:id])
    @students = @course.users.where("user_role=?","student")
    @teacher = current_user
    @user = current_user
  end
  
  def questions_manage
    @teacher = User.find(params[:tid])
    @user = @teacher
    @course = Course.find(params[:cid])
    @question = @course.knowledges.where("type=?","Question")
    @question = @question.paginate(:page => params[:page], :per_page => 2)
  end
  
  def blogs_manage
    @teacher = User.find(params[:tid])
    @user = @teacher
    @course = Course.find(params[:cid])
    @blog = @course.knowledges.where("type=?","Blog")
    @blog = @blog.paginate(:page => params[:page], :per_page => 2)
  end
  
  def resources_manage
    @teacher = User.find(params[:tid])
    @user = @teacher
    @course = Course.find(params[:cid])
    @resource = @course.knowledges.where("type=?","Resource")
    @resource = @resource.paginate(:page => params[:page], :per_page => 2)
  end

  def ajaxnames
    @teacher_id = params[:id]
    respond_to do |format|
        format.js{}
    end
  end
  private
    def user_param
      params.require(:user).permit(:username, :email, :password, :password_confirmation, :phone_number, :user_role, :nickname)
    end
    
    
end