require "knowledges_controller"

class QuestionsController < KnowledgesController
    def new
        super
        @question = Question.new
    end
end
