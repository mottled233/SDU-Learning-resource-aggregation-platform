require "knowledges_controller"

class ResourcesController < KnowledgesController
    def index
        @resource = Resource.all
    end
    def new
        super
        @resource = Resource.new
        @keywords = Keyword.all
    end
     def show
        resources = Resource.all
        @knowledge = resources[params[:id].to_i-1]
        if @knowledge.nil?
            @knowledge = Knowledge.find(params[:id])
        end
    end
    def create
        @resource = Resource.new(resource_params);
        filename = uploadfile(params[:resource][:attachment])  
        @resource.attachment = filename  
        @resource.save
        keyword_list = params[:keywords];
        keyword_list.each do |key|
            keyword_knowledge_relationships = @resource.keyword_knowledge_associations.create
            keyword_knowledge_relationships.keyword = Keyword.find(key)
            keyword_knowledge_relationships.save
        end
        course_list = params[:courses];
        course_list.each do |c|
            course_knowledge_relationships = @resource.course_knowledge_associations.create
            course_knowledge_relationships.course = Course.find(c)
            course_knowledge_relationships.save
        end
        redirect_to resource_path(@resource)
    end
    def file_download  
        resource = Resource.find(params[:r_id])  
        send_file "#{Rails.root}/public/upload/#{resource[:attachment]}"
    end  
     private
    # Never trust parameters from the scary internet, only allow the white list through.
    def resource_params
      params.require(:resource).permit(:user_id,:title, :type,:content, :good, :bad)
    end
    def uploadfile(file)  
        if !file.original_filename.empty?  
          @filename = file.original_filename  
          #设置目录路径，如果目录不存在，生成新目录  
          FileUtils.mkdir("#{Rails.root}/public/upload") unless File.exist?("#{Rails.root}/public/upload")  
          #写入文件  
          ##wb 表示通过二进制方式写，可以保证文件不损坏  
          File.open("#{Rails.root}/public/upload/#{@filename}", "wb") do |f|  
            f.write(file.read)  
          end  
          return @filename  
        end  
    end  
end
