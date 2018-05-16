class SpecialitiesController < ApplicationController
  before_action :confirm_logged_in, only: [:show, :edit, :update, :destroy, :create, :deleteCourseDeptAss, :newcourseass, :create_course_association]
  before_action :confirm_is_admin, only: [:own_space, :edit, :update]
    
  before_action :set_speciality, only: [:show, :edit, :update, :destroy]


  def index
    @specialities = Speciality.all
  end

  # GET /departments/1
  # GET /departments/1.json
  def show
    @department = @speciality.department
    @courses = @speciality.courses
  end

  # GET /departments/new
  def new
    @speciality = Speciality.new
  end

  # GET /departments/1/edit
  def edit
  end

  # POST /departments
  # POST /departments.json
  def create
    sp = speciality_params
    has_department = true
    has_department = !(!params[:speciality][:department_id].nil? && Department.where("id=?",params[:speciality][:department_id]).empty?)
    # debugger
    if !has_department
      format.html { render :edit }
    else
      sp[:department] = Department.find(params[:speciality][:department_id])
    end
    @speciality = Speciality.new(sp)

    respond_to do |format|
      if @speciality.save
        format.html { redirect_to @speciality, notice: 'Department was successfully created.' }
        format.json { render :show, status: :created, location: @department }
      else
        format.html { render :new }
        format.json { render json: @speciality.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /departments/1
  # PATCH/PUT /departments/1.json
  def update
    sp = speciality_params
    has_department = true
    has_department = !(!params[:speciality][:department_id].nil? && Department.where("id=?",params[:speciality][:department_id]).empty?)
    # debugger
    if !has_department
      format.html { render :edit }
    else
      sp[:department] = Department.find(params[:speciality][:department_id])
    end
    respond_to do |format|
      if @speciality.update(sp)
        format.html { redirect_to @speciality, notice: '修改成功' }
        format.json { render :show, status: :ok, location: @speciality }
      else
        format.html { render :edit }
        format.json { render json: @speciality.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /departments/1
  # DELETE /departments/1.json
  def destroy
    @speciality.destroy
    respond_to do |format|
      format.html { redirect_to specialities_url, notice: 'Speciality was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def deleteCourseDeptAss
    @speciality = set_speciality
    @courseAss = @speciality.course_speciality_associations.where("course_id =?",params[:cid])
    CourseSpecialityAssociation.delete(@courseAss.first.id)
    
    respond_to do |format|
      format.html { redirect_to @speciality, notice: 'SpecialityCourseAss was successfully destroyed.' }
      format.json { head :no_content }
    end
    
  end
  
  def newcourseass
    @speciality = Speciality.find(params[:id])
    @course_speciality_association = @speciality.course_speciality_associations.new()
  end
  
  def create_course_association
    has_that_spec = !Speciality.where("id=?",params[:course_speciality_association][:speciality]).empty?
    has_that_course = !Course.where("id=?",params[:course_speciality_association][:course]).empty?
    @redirect_path = params[:course_speciality_association][:path]
    if !has_that_course
      respond_to do |format|
        format.html { redirect_to @redirect_path, notice: "No that course." }
      end
    elsif !has_that_spec
      respond_to do |format|
        format.html { redirect_to @redirect_path, notice: "No that speciality." }
      end  
    else
      @speciality = Speciality.find(params[:course_speciality_association][:speciality])
      @course = Course.find(params[:course_speciality_association][:course])
      
      has_that_ass = !CourseSpecialityAssociation.where("speciality_id = ? AND course_id =?" ,@speciality.id,@course.id).empty?
      @speciality_course_relationship = @speciality.course_speciality_associations.new
      @speciality_course_relationship.course = @course
  
      
      respond_to do |format|
        if has_that_ass
          format.html { redirect_to @redirect_path, notice: "Has That Speciality Course Association." }
        else
          if @speciality_course_relationship.save
            format.html { redirect_to @redirect_path, notice: "Speciality Course Association was successfully created." }
          else
            format.html { render :new }
          end
        end
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_speciality
      @speciality = Speciality.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def speciality_params
      params.require(:speciality).permit(:name,:department)
    end
end
