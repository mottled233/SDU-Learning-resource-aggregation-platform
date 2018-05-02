require "knowledges_controller"

class QuestionsController < KnowledgesController
    def new
        super
        @question = Question.new
        @keywords = Keyword.all
    end
    
    def create
        # @question = Question.new(creator: params[:creator],title: params[:title],type:'Question',content:params[:content],good:0,bad:0)
        @question = Question.new(question_params);
        @question.save
        redirect_to question_path(@question)
    end
     private
    # Never trust parameters from the scary internet, only allow the white list through.
    def question_params
      params.require(:question).permit(:creator_id,:title, :type,:content, :good, :bad)
    end

end
