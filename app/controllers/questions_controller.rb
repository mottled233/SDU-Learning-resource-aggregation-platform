require "knowledges_controller"

class QuestionsController < KnowledgesController
    def index
        @question = Question.all
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
        questions = Question.all
        @knowledge = questions[params[:id].to_i-1]
        if @knowledge.nil?
            @knowledge = Knowledge.find(params[:id])
        end
    end
     def edit
        @question = Question.find(params[:id])
        @courses =  Course.all
        @keywords = Keyword.all
    end
    def create
        # @question = Question.new(creator: params[:creator],title: params[:title],type:'Question',content:params[:content],good:0,bad:0)
        @question = Question.new(question_params);
        @question.save
        keyword_list = params[:keywords];
        course_list = params[:courses];
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
        
        
        redirect_to question_path(@question)
    end
     def update
        @question = Question.find(params[:id])
          if @question.update(question_params)
            redirect_to question_path(@question)
            keyword_list = params[:keywords];
            course_list = params[:courses];
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
            format.html { render :edit }
          end
        
    end
     private
    # Never trust parameters from the scary internet, only allow the white list through.
    def question_params
      params.require(:question).permit(:user_id,:title, :type,:content, :good, :bad)
    end

end
