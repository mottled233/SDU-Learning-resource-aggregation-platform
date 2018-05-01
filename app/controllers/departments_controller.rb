class DepartmentsController < ApplicationController
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
    @department = Department.find(params[:course_department_association][:department])
    has_that_course = !Course.where("id=?",params[:course_department_association][:course]).empty?
    if !has_that_course
      respond_to do |format|
        format.html { redirect_to @department, notice: "No that course." }
        format.json { render json: @department.errors, status: :unprocessable_entity, location: @department }
      end
    else
      @course = Course.find(params[:course_department_association][:course])
      
      has_that_ass = !CourseDepartmentAssociation.where("department_id = ? AND course_id =?" ,@department.id,@course.id).empty?
      @department_course_relationship = @department.course_department_associations.new
      @department_course_relationship.course = @course
  
      
      respond_to do |format|
        if has_that_ass
          format.html { redirect_to @department, notice: "Has That Department Course Association." }
          format.json { render json: @department.errors, status: :unprocessable_entity, location: @department }
        else
          if @department_course_relationship.save
            format.html { redirect_to @department, notice: "Department Course Association was successfully created." }
            format.json { render :show, status: :created, location: @department }
          else
            format.html { render :new }
            format.json { render json: @department.errors, status: :unprocessable_entity }
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
