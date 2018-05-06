class TeachersController < ApplicationController

    

  def index
    @teachers = User.where("user_role=?",:teacher)
  end
  
  def show
    @teacher = User.find(params[:id])
    @courses = @teacher.selected_courses
  end
  
  # def edit
  # end
  
  def newcourseass
    @teacher = User.find(params[:id])
    @course_teacher_association = @teacher.course_user_associations.new()
  end
  
  def create_course_association
    has_that_teacher = !User.where("id=?",params[:course_user_association][:user]).empty?
    has_that_course = !Course.where("id=?",params[:course_user_association][:course_id]).empty?
    @redirect_path = teachers_newcourseass_path(params[:course_user_association][:user])
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
            format.html { redirect_to teacher_path(@teacher), notice: "Teacher Course Association was successfully created." }
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

    
end