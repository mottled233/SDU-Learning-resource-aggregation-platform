require "knowledges_controller"
require 'will_paginate/array'
class QuestionsController < KnowledgesController
    def index
        @question = Question.all
        @question = @question.sort_by{ |created_at| created_at }.reverse
        @question = @question.paginate(:page => params[:page], :per_page => 4)
    end
    def destroy
        @question = Question.find(params[:id])
        @question.destroy
        redirect_to :back
    end
    def new
        super
        @question = Question.new
        @keywords = Keyword.all
    end
    def show
        @knowledge = Knowledge.find(params[:id])
        @knowledge.visit_count = @knowledge.visit_count+1
        @knowledge.save
    end
    def edit
        @question = Question.find(params[:id])
        @courses =  Course.all
        @keywords = Keyword.all
    end
    def create
        @question = Question.new(question_params);
        b = true;
        if @question.save
            keyword_list = params[:keywords];
            if !keyword_list.nil?
                keyword_list.each do |key|
                    keyword_knowledge_relationships = @question.keyword_knowledge_associations.create
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
                    course_knowledge_relationships = @question.course_knowledge_associations.create
                    course_knowledge_relationships.course = Course.find(c)
                    course_knowledge_relationships.save
                end
            else
                b = false;
                flash[:notice] = '无关联课程'
                redirect_to :back
            end
            if b
                redirect_to question_path(@question)
            end
        else
            flash[:notice] = '不合法的参数'
            redirect_to :back
        end
    end
   def update
        @question = Question.find(params[:id])
        b = true;
        respond_to do |format|
          if @question.update(question_params)
            redirect_to question_path(@question)
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
                @question.keywords.each do |key|
                    if !keyword_list.include?(key)
                            @question.keywords.delete(key);
                    end
                end
                @question.courses.each do |c|
                    if !course_list.include?(c)
                            @question.courses.delete(c);
                    end
                end
                if !keyword_list.nil?
                    keyword_list.each do |key|
                        keyword_knowledge_relationships = @question.keyword_knowledge_associations.create
                        keyword_knowledge_relationships.keyword = Keyword.find(key)
                        keyword_knowledge_relationships.save
                    end
                end
                if !course_list.nil?
                    course_list.each do |c|
                        
                        course_knowledge_relationships = @question.course_knowledge_associations.create
                        course_knowledge_relationships.course = Course.find(c)
                        course_knowledge_relationships.save
                    end
                end
            else
                format.html { render :edit } and return
            end
          else
             flash[:notice] = '不合法的参数'
             format.html { render :edit } and return
          end
        end
    end
private
    # Never trust parameters from the scary internet, only allow the white list through.
    def question_params
      params.require(:question).permit(:user_id,:title, :type,:content, :good, :bad)
    end

end
