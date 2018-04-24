require "knowledges_controller"

class BlogsController < KnowledgesController
    def new
        super
        @blog = Blog.new
    end
end
