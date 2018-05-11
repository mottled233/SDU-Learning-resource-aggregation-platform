require "knowledges_controller"

class BlogsController < KnowledgesController
    def index
        @blog = Blog.all
    end
    def new
        super
        @blog = Blog.new
        @keywords = Keyword.all
    end
    def show
        blogs = Blog.all
        @knowledge = blogs[params[:id].to_i-1]
        if @knowledge.nil?
            @knowledge = Knowledge.find(params[:id])
        end
    end
    def create
        @blog = Blog.new(blog_params);
        @blog.save
        keyword_list = params[:keywords];
        keyword_list.each do |key|
            keyword_knowledge_relationships = @blog.keyword_knowledge_associations.create
            keyword_knowledge_relationships.keyword = Keyword.find(key)
            keyword_knowledge_relationships.save
        end
        course_list = params[:courses];
        course_list.each do |c|
            course_knowledge_relationships = @blog.course_knowledge_associations.create
            course_knowledge_relationships.course = Course.find(c)
            course_knowledge_relationships.save
        end
        
        
        redirect_to blog_path(@blog)
    end
     private
    # Never trust parameters from the scary internet, only allow the white list through.
    def blog_params
      params.require(:blog).permit(:user_id,:title, :type,:content, :good, :bad)
    end

end
