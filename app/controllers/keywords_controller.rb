class KeywordsController < ApplicationController
  before_action :set_keyword, only: [:show, :edit, :update, :destroy]
  before_action :confirm_logged_in
  before_action :confirm_is_admin
  
  

  # GET /keywords
  # GET /keywords.json
  def index
    @keywords = Keyword.all
  end

  # GET /keywords/1
  # GET /keywords/1.json
  def show
    
  end

  # GET /keywords/new
  def new
    @keyword = Keyword.new
  end

  # GET /keywords/1/edit
  def edit
  end

  # POST /keywords
  # POST /keywords.json
  def create
    @keyword = Keyword.new(keyword_params)
    # @easterEgg = 'Enjoy your work and have a nice day! --wang ziyue'
    @notice = 'Keyword was successfully created.'
    if params[:keyword][:name] == '好累'
      @notice = @easterEgg
    end
    respond_to do |format|
      if @keyword.save
        format.html { redirect_to @keyword, notice: "#{@notice}" }
        format.json { render :show, status: :created, location: @keyword }
      else
        format.html { render :new }
        format.json { render json: @keyword.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /keywords/1
  # PATCH/PUT /keywords/1.json
  def update
    respond_to do |format|
      if @keyword.update(keyword_params)
        format.html { redirect_to @keyword, notice: 'Keyword was successfully updated.' }
        format.json { render :show, status: :ok, location: @keyword }
      else
        format.html { render :edit }
        format.json { render json: @keyword.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /keywords/1
  # DELETE /keywords/1.json
  def destroy
    @keyword.destroy
    respond_to do |format|
      format.html { redirect_to keywords_url, notice: 'Keyword was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def destory_low_association
    
    
    kre = KeywordRelationship.where("higher_id=? AND lower_id=?",params[:hid],params[:lid]).first
    KeywordRelationship.delete(kre.id)
    respond_to do |format|
      format.html { redirect_to Keyword.find(params[:hid]), notice: '上下级关系已取消.' }
      format.json { head :no_content }
    end
  end
  
  def destory_high_association
    
    
    kre = KeywordRelationship.where("higher_id=? AND lower_id=?",params[:hid],params[:lid]).first
    KeywordRelationship.delete(kre.id)
    respond_to do |format|
      format.html { redirect_to Keyword.find(params[:lid]), notice: '上下级关系已取消.' }
      format.json { head :no_content }
    end
  end
  
  def newkeywordass
    @keywords_associations = KeywordRelationship.new()
  end
  
  def create_association
    has_that_low = !Keyword.where("id=?",params[:keyword_relationship][:lower_id]).empty?
    has_that_high = !Keyword.where("id=?",params[:keyword_relationship][:higher_id]).empty?
    @redirect_path = keywords_path
    if !has_that_low
      respond_to do |format|
        format.html { redirect_to @redirect_path, notice: "指定下级不存在." }
      end
    elsif !has_that_high
      respond_to do |format|
        format.html { redirect_to @redirect_path, notice: "指定上级不存在." }
      end  
    else
      @low = Keyword.find(params[:keyword_relationship][:lower_id])
      @high = Keyword.find(params[:keyword_relationship][:higher_id])
      
      has_that_ass = !KeywordRelationship.where("lower_id = ? AND higher_id =?" ,@high.id,@low.id).empty?
      @keywords_associations = @low.higher_relationships.new()
      @keywords_associations.higher = @high

      
      respond_to do |format|
        if has_that_ass
          format.html { redirect_to @redirect_path, notice: "关联已存在." }
        else
          if @keywords_associations.save
            format.html { redirect_to @redirect_path, notice: "成功创建." }
          else
            format.html { render :new }
          end
        end
      end
    end
  end
  
  def attachtocourse
    @keyword = Keyword.find(params[:id])
    @keyword_course_association = @keyword.course_keyword_associations.new()
  end
  
  def create_course_keyword_ass
    has_that_keyword = !Keyword.where("id=?",params[:course_keyword_association][:keyword_id]).empty?
    has_that_course = !Course.where("id=?",params[:course_keyword_association][:course_id]).empty?
    @redirect_path = params[:course_keyword_association][:path]
    if !has_that_keyword
      respond_to do |format|
        format.html { redirect_to @redirect_path, notice: "指定关键字不存在." }
      end
    elsif !has_that_course
      respond_to do |format|
        format.html { redirect_to @redirect_path, notice: "指定课程不存在." }
      end  
    else
      @keyword = Keyword.find(params[:course_keyword_association][:keyword_id])
      @course = Course.find(params[:course_keyword_association][:course_id])
      
      has_that_ass = !CourseKeywordAssociation.where("course_id = ? AND keyword_id =?" ,@course.id,@keyword.id).empty?
      @keyword_course_association = @keyword.course_keyword_associations.new()
      @keyword_course_association.course = @course

      
      respond_to do |format|
        if has_that_ass
          format.html { redirect_to @redirect_path, notice: "关联已存在." }
        else
          if @keyword_course_association.save
            format.html { redirect_to keyword_path(@keyword), notice: "成功创建." }
          else
            format.html { render :new }
          end
        end
      end
    end
  end
  

  
  def ajaxkeywordname
    @keyword_id = params[:id]
    respond_to do |format|
        format.js{}
    end
  end
  
  def ajaxkeywordnamelow
    @keyword_id = params[:id]
    respond_to do |format|
        format.js{}
    end
  end
  
  def ajaxkeywordnamehigh
    @keyword_id = params[:id]
    respond_to do |format|
        format.js{}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_keyword
      @keyword = Keyword.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def keyword_params
      params.require(:keyword).permit(:name, :course)
    end
end
