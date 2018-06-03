require "knowledges_controller"
require 'will_paginate/array'
class BlogsController < KnowledgesController
    include ApplicationHelper
    before_action :record_visit, only: [:show]
    skip_before_filter :verify_authenticity_token, :only => [:render_keyword,:render_department,:render_spe,:render_newCourse]
    def index
        @blog = Blog.all
        @blog = @blog.where("check_state=?",1)
        @blog = @blog.sort_by{ |created_at| created_at }.reverse
        @blog = @blog.paginate(:page => params[:page], :per_page => 4)
    end
    def destroy
        @blog = Blog.find(params[:id])
        @blog.destroy
        redirect_to :back
    end
    def new
        super
        @blog = Blog.new
        @keywords = Keyword.all
    end
    def show
        @knowledge = Knowledge.find(params[:id])
        @knowledge.visit_count = @knowledge.visit_count+1
        @knowledge.save
    end
    def edit
        @blog = Blog.find(params[:id])
        @courses =  Course.all
        @keywords = Keyword.all
    end
    def create
        @blog = Blog.new(blog_params);
        @blog.check_state = 0
        # src = @blog.content.match("<img\b[^<>]*?\bsrc[\s\t\r\n]*=[\s\t\r\n]*[""']?[\s\t\r\n]*(?<imgUrl>[^\s\t\r\n""'<>]*)[^<>]*?/?[\s\t\r\n]*>")
        if(@blog.knowledge_digest.nil?||@blog.knowledge_digest.empty?)
            @blog.knowledge_digest = short_digest(@blog.content,50) 
        end
        b = true;
        if @blog.save
            keyword_list = params[:keywords];
            if !keyword_list.nil?
                keyword_list.each do |key|
                    keyword_knowledge_relationships = @blog.keyword_knowledge_associations.create
                    keyword_knowledge_relationships.keyword = Keyword.find(key)
                    keyword_knowledge_relationships.save
                end
            else
                b = false;
                flash[:notice] = '无关联关键词'
                redirect_to :back
            end
            course_list = params[:courses];
            if !course_list.nil?
                course_list.each do |c|
                    course_knowledge_relationships = @blog.course_knowledge_associations.create
                    course_knowledge_relationships.course = Course.find(c)
                    course_knowledge_relationships.save
                end
            else
                b = false;
                flash[:notice] = '无关联课程'
                redirect_to :back
            end
            if b
                redirect_to blog_path(@blog)
            end
        else
            flash[:notice] = '不合法的参数'
            redirect_to :back
        end
    end
   def update
        @blog = Blog.find(params[:id])
        @blog.check_state = 0
        b = true;
          if @blog.update(blog_params)
            if((@blog.knowledge_digest.nil?||@blog.knowledge_digest.empty?))
                @blog.knowledge_digest = short_digest(@blog.content,50) 
            end
            redirect_to blog_path(@blog)
            keyword_list = params[:keywords];
            course_list = params[:courses];
            
            if keyword_list.nil?
                b = false;                
                flash[:notice] = '无关联关键词'
            end
            
            if course_list.nil?
                b = false; 
                flash[:notice] = '无关联课程'
            end
            
            if b
                @blog.keywords.each do |key|
                    if !keyword_list.include?(key)
                            @blog.keywords.delete(key);
                    end
                end
                @blog.courses.each do |c|
                    if !course_list.include?(c)
                            @blog.courses.delete(c);
                    end
                end
                if !keyword_list.nil?
                    keyword_list.each do |key|
                        keyword_knowledge_relationships = @blog.keyword_knowledge_associations.create
                        keyword_knowledge_relationships.keyword = Keyword.find(key)
                        keyword_knowledge_relationships.save
                    end
                end
                if !course_list.nil?
                    course_list.each do |c|
                        
                        course_knowledge_relationships = @blog.course_knowledge_associations.create
                        course_knowledge_relationships.course = Course.find(c)
                        course_knowledge_relationships.save
                    end
                end
            else
                  render :edit 
                  return
            end
          else
             flash[:notice] = '不合法的参数'
             render :edit
             return
          end
    end
    def render_keyword
        option_id = params[:keyword]
        @info = params[:info]
        @hasChoose  = params[:hasChoose]
        @chooseItem = Array.new;
        
            
        if !@hasChoose.nil?
            @hasChoose.each do |c| 
                @chooseItem << Keyword.find(c)
            end
        end
        if option_id.eql?("-1")
            @info = 1
            @after = Keyword.getFirstLayer(Keyword.all-@chooseItem)
            render "render_haschoose.js.erb"
        else
            @raw  = Keyword.find(params[:keyword])
            @info = @info.to_i+1
            @after = @raw.lowers
            if @after.nil?||@after.empty?
                @chooseItem = @chooseItem<<@raw
                @info = 1;
                @after = Keyword.getFirstLayer(Keyword.all-@chooseItem)
                render "render_haschoose.js.erb"
            elsif
                @after = @after - @chooseItem 
                render "render_select.js.erb"
            end
        end
        respond_to do |format|
            format.js {}
        end
    end
    def render_department
        @department = Department.find(params[:department])
        @speciality = @department.specialities
        render "render_speciality.js.erb"
        respond_to do |format|
            format.js {}
        end
    end
    def render_spe
        @speciality = Speciality.find(params[:speciality])
        @course = @speciality.courses
        @hasChoose  = params[:hasChoose]
        @chooseItem = Array.new;
            
        if !@hasChoose.nil?
            @hasChoose.each do |c| 
                @chooseItem << Keyword.find(c)
            end
        end
        
        if @course.nil?||@course.empty?
            @course = @course-@chooseItem
        end
        render "render_course.js.erb"
        respond_to do |format|
            format.js {}
        end
    end
    def render_newCourse
        @course = Course.find(params[:course])
        @hasChoose  = params[:hasChoose]
        @chooseItem = Array.new;
            
        if !@hasChoose.nil?
            @hasChoose.each do |c| 
                @chooseItem << Keyword.find(c)
            end
        end
        @chooseItem = @chooseItem<<@course
        render "render_hasChooseCourse.js.erb"
        respond_to do |format|
            format.js {}
        end
    end
private
    # Never trust parameters from the scary internet, only allow the white list through.
    def blog_params
      params.require(:blog).permit(:user_id,:title, :type,:content, :good, :bad,:knowledge_digest)
    end
end
