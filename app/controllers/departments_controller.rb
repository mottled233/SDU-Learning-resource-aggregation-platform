class DepartmentsController < ApplicationController
  before_action :confirm_logged_in, only: [:show, :edit, :update, :destroy, :create, :deleteCourseDeptAss, :newcourseass, :create_course_association]
  before_action :confirm_is_admin, only: [:own_space, :edit, :update]
    
  before_action :set_department, only: [:show, :edit, :update, :destroy]

  # GET /departments
  # GET /departments.json
  def index
    @departments = Department.all
  end

  # GET /departments/1
  # GET /departments/1.json
  def show
  end

  # GET /departments/new
  def new
    @department = Department.new
  end

  # GET /departments/1/edit
  def edit
  end

  # POST /departments
  # POST /departments.json
  def create
    @department = Department.new(department_params)

    respond_to do |format|
      if @department.save
        format.html { redirect_to @department, notice: 'Department was successfully created.' }
        format.json { render :show, status: :created, location: @department }
      else
        format.html { render :new }
        format.json { render json: @department.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /departments/1
  # PATCH/PUT /departments/1.json
  def update
    respond_to do |format|
      if @department.update(department_params)
        format.html { redirect_to @department, notice: 'Department was successfully updated.' }
        format.json { render :show, status: :ok, location: @department }
      else
        format.html { render :edit }
        format.json { render json: @department.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /departments/1
  # DELETE /departments/1.json
  def destroy
    @department.destroy
    respond_to do |format|
      format.html { redirect_to departments_url, notice: 'Department was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def deleteCourseDeptAss
    @department = set_department
    @courseAss = @department.course_department_associations.where("course_id =?",params[:cid])
    CourseDepartmentAssociation.delete(@courseAss.first.id)
    
    respond_to do |format|
      format.html { redirect_to @department, notice: 'DepartmentCourseAss was successfully destroyed.' }
      format.json { head :no_content }
    end
    
  end
  
  def newcourseass
    @department = Department.find(params[:id])
    @course_department_associations = @department.course_department_associations.new()
  end
  
  def create_course_association
    has_that_dept = !Department.where("id=?",params[:course_department_association][:department]).empty?
    has_that_course = !Course.where("id=?",params[:course_department_association][:course]).empty?
    @redirect_path = params[:course_department_association][:path]
    if !has_that_course
      respond_to do |format|
        format.html { redirect_to @redirect_path, notice: "No that course." }
      end
    elsif !has_that_dept
      respond_to do |format|
        format.html { redirect_to @redirect_path, notice: "No that department." }
      end  
    else
      @department = Department.find(params[:course_department_association][:department])
      @course = Course.find(params[:course_department_association][:course])
      
      has_that_ass = !CourseDepartmentAssociation.where("department_id = ? AND course_id =?" ,@department.id,@course.id).empty?
      @department_course_relationship = @department.course_department_associations.new
      @department_course_relationship.course = @course
  
      
      respond_to do |format|
        if has_that_ass
          format.html { redirect_to @redirect_path, notice: "Has That Department Course Association." }
        else
          if @department_course_relationship.save
            format.html { redirect_to @redirect_path, notice: "Department Course Association was successfully created." }
          else
            format.html { render :new }
          end
        end
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_department
      @department = Department.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def department_params
      params.require(:department).permit(:name)
    end
end
