require "knowledges_controller"

class BlogsController < KnowledgesController
    def index
        @blog = Blog.all
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
    end
    def edit
        @blog = Blog.find(params[:id])
        @courses =  Course.all
        @keywords = Keyword.all
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
   def update
        @blog = Blog.find(params[:id])
          if @blog.update(blog_params)
            redirect_to blog_path(@blog)
            keyword_list = params[:keywords];
            course_list = params[:courses];
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
            format.html { render :edit }
          end
        
    end
private
    # Never trust parameters from the scary internet, only allow the white list through.
    def blog_params
      params.require(:blog).permit(:user_id,:title, :type,:content, :good, :bad)
    end

end
