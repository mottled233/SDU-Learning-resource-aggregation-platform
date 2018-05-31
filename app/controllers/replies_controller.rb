require "knowledges_controller"

class RepliesController < ApplicationController
    def new
        super
        @reply = Reply.new
    end
    def create
        # @question = Question.new(creator: params[:creator],title: params[:title],type:'Question',content:params[:content],good:0,bad:0)
        @reply = Reply.new(reply_params)
        if @reply.save
            t = @reply.topic.type
            if t.eql?('Question')
                redirect_to question_path(@reply.topic)
            elsif t.eql?('Resource')
                redirect_to resource_path(@reply.topic)
            elsif t.eql?('Blog')
                redirect_to blog_path(@reply.topic)
            elsif t.eql?('Reply')
                flash[:notice] = "评论成功"
                redirect_to :back
            end
            r = @reply;
            while !r.nil?
                r.last_reply_at = Time.now
                if r.type.eql?("Reply")
                    r = r.topic
                else
                    break
                end
            end
        else
            flash[:notice] = "不合法参数"
            redirect_to :back
        end
    end
     private
    # Never trust parameters from the scary internet, only allow the white list through.
    def reply_params
      params.require(:reply).permit(:user_id, :knowledge_id,:type,:content, :good, :bad)
    end
    
end
