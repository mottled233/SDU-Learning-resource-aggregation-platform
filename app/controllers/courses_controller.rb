class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy]


  # GET /courses
  # GET /courses.json
  def index
    @courses = Course.all
  end

  # GET /courses/1
  # GET /courses/1.json
  def show
  end

  # GET /courses/new
  def new
    @course = Course.new
  end
  
  # GET /courses/1/edit
  def edit
  end
  
  ########################################################################################################
  def home
  end

  def question
    @question = Knowledge.get_all_entry('Question')
    @courses = set_course
  end

  def blog
    @blog = Knowledge.get_all_entry('Question')
    @courses = set_course
  end

  def resource
  end

  

  
  ##########################################################################################################
  
  
  
  # POST /courses
  # POST /courses.json
  def create
    @course = Course.new(course_params)

    respond_to do |format|
      if @course.save
        format.html { redirect_to @course, notice: 'Course was successfully created.' }
        format.json { render :show, status: :created, location: @course }
      else
        format.html { render :new }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /courses/1
  # PATCH/PUT /courses/1.json
  def update
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to @course, notice: 'Course was successfully updated.' }
        # format.json { render :show, status: :ok, location: @course }
      else
        format.html { render :edit }
        # format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    @course.destroy
    respond_to do |format|
      format.html { redirect_to courses_url, notice: 'Course was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def questions_index
    @course = Course.find(params[:course_id])
    @question = Knowledge.get_all_entry('Question')
    # debugger
  end
  
  def blogs_index
    @course = Course.find(params[:course_id])
    @blog = Knowledge.get_all_entry('Blog')
  end
  
  def resources_index
    @course = Course.find(params[:course_id])
    @resource = Knowledge.get_all_entry('Resource')
  end
  
  def course_departments_index
    @course = Course.find(params[:id])
    @cd_ass = @course.course_department_associations
  end
  
  def newdeptass
    @course = Course.find(params[:id])
    @course_department_associations = @course.course_department_associations.new()
  end
  
  def deleteCourseDeptAss
    @department = set_department
    @courseAss = @department.course_department_associations.where("course_id =?",params[:cid])
    CourseDepartmentAssociation.delete(@courseAss.first.id)
    
    respond_to do |format|
      format.html { redirect_to courses_course_departments_index_path(params[:cid]), notice: 'DepartmentCourseAss was successfully destroyed.' }
      format.json { head :no_content }
    end
    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_params
      params.require(:course).permit(:course_name, :knowledge, :teacher, :teacher_relationship, :department_id)
    end
    
end
