require "knowledges_controller"

class RepliesController < ApplicationController
    def new
        super
        @reply = Reply.new
    end
    def create
        # @question = Question.new(creator: params[:creator],title: params[:title],type:'Question',content:params[:content],good:0,bad:0)
        @reply = Reply.new(reply_params)
        @reply.save
        t = @reply.topic.type
        if t.eql?('Question')
            redirect_to question_path(@reply.topic)
        elsif t.eql?('Resource')
            redirect_to resource_path(@reply.topic)
        elsif t.eql?('Blog')
            redirect_to blog_path(@reply.topic)
        end
            
    end
     private
    # Never trust parameters from the scary internet, only allow the white list through.
    def reply_params
      params.require(:reply).permit(:creator_id, :topic_id,:type,:content, :good, :bad)
    end
    
end
