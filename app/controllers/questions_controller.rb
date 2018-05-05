require "knowledges_controller"

class QuestionsController < KnowledgesController
    def index
        @question = Question.all
    end
    def new
        super
        @question = Question.new
        @keywords = Keyword.all
    end
    def show
        questions = Question.all
        @knowledge = questions[params[:id].to_i]
        if @knowledge.nil?
            @knowledge = Knowledge.find(params[:id])
        end
    end
    def create
        # @question = Question.new(creator: params[:creator],title: params[:title],type:'Question',content:params[:content],good:0,bad:0)
        @question = Question.new(question_params);
        @question.save
        keyword_list = params[:keywords];
        keyword_list.each do |key|
            keyword_knowledge_relationships = @question.keyword_knowledge_associations.create
            keyword_knowledge_relationships.keyword = Keyword.find(key)
            keyword_knowledge_relationships.save
        end
        course_list = params[:courses];
        course_list.each do |c|
            course_knowledge_relationships = @question.course_knowledge_associations.create
            course_knowledge_relationships.course = Course.find(c)
            course_knowledge_relationships.save
        end
        
        
        redirect_to question_path(@question)
    end
     private
    # Never trust parameters from the scary internet, only allow the white list through.
    def question_params
      params.require(:question).permit(:creator_id,:title, :type,:content, :good, :bad)
    end

end
