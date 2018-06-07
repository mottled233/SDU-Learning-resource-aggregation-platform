require "knowledges_controller"
require 'will_paginate/array'
class ResourcesController < KnowledgesController
    include ApplicationHelper
    before_action :record_visit, only: [:show]
    
    def index
        @resource = Resource.all
        @resource = @resource.where("check_state=?",1)
        @resource = @resource.sort_by{ |created_at| created_at }.reverse
        @resource = @resource.paginate(:page => params[:page], :per_page => 4)
    end
    def new
        super
        @resource = Resource.new
        @keywords = Keyword.all
    end
     def show
        @knowledge = Knowledge.find(params[:id])
        @knowledge.visit_count = @knowledge.visit_count+1
        @knowledge.save
    end
     def edit
        @resource = Resource.find(params[:id])
        @courses =  Course.all
        @keywords = Keyword.all
    end
    def destroy
        @resource = Resource.find(params[:id])
        @resource.destroy
        redirect_to :back
    end
    def create
        @resource = Resource.new(resource_params);
        @resource.check_state = 0;
        b = true;
        if(@resource.knowledge_digest.nil?||@resource.knowledge_digest.empty?)
            @resource.knowledge_digest = short_digest(@resource.content,50) 
        end
        filename = uploadfile(params[:resource][:attachment])  
        @resource.attachment = filename  
        if @resource.save
            keyword_list = params[:keywords];
            if !keyword_list.nil?
                keyword_list.each do |key|
                    keyword_knowledge_relationships = @resource.keyword_knowledge_associations.create
                    keyword_knowledge_relationships.keyword = Keyword.find(key)
                    keyword_knowledge_relationships.save
                end
            else
                b = false;
                flash[:notice] = '无关联关键词'
                redirect_to :back
            end
            course_list = params[:courses];
            if !course_list.nil?
                course_list.each do |c|
                    course_knowledge_relationships = @resource.course_knowledge_associations.create
                    course_knowledge_relationships.course = Course.find(c)
                    course_knowledge_relationships.save
                end
            else
                b = false;
                flash[:notice] = '无关联课程'
                redirect_to :back
            end
            if b
                redirect_to resource_path(@resource)
            end
        else
            flash[:notice] = '不合法的参数'
            redirect_to :back
        end
    end
    def update
        @resource = Resource.find(params[:id])
        @resource.check_state = 0;
        if !params[:resource][:attachment].nil?
             filename = uploadfile(params[:resource][:attachment])  
             @resource.attachment = filename  
        end
         b = true;
          if @resource.update(resource_params)
            if(@resource.knowledge_digest.nil?||@resource.knowledge_digest.empty?)
                @resource.knowledge_digest = short_digest(@resource.content,50) 
            end
            redirect_to resource_path(@resource)
            keyword_list = params[:keywords];
            course_list = params[:courses];
            if keyword_list.nil?
                b = false;                
                flash[:notice] = '无关联关键词'
            end
            if course_list.nil?
                b = false; 
                flash[:notice] = '无关联课程'
            end
            
            if b
                @resource.keywords.each do |key|
                    if !keyword_list.include?(key)
                            @resource.keywords.delete(key);
                    end
                end
                @resource.courses.each do |c|
                    if !course_list.include?(c)
                            @resource.courses.delete(c);
                    end
                end
                if !keyword_list.nil?
                    keyword_list.each do |key|
                        keyword_knowledge_relationships = @resource.keyword_knowledge_associations.create
                        keyword_knowledge_relationships.keyword = Keyword.find(key)
                        keyword_knowledge_relationships.save
                    end
                end
                if !course_list.nil?
                    course_list.each do |c|
                        
                        course_knowledge_relationships = @resource.course_knowledge_associations.create
                        course_knowledge_relationships.course = Course.find(c)
                        course_knowledge_relationships.save
                    end
                end
            else
                render :edit
                return
            end
          else
             flash[:notice] = '不合法的参数'
             render :edit
             return
          end
        
    end
    def file_download  
        resource = Resource.find(params[:r_id])  
        resource.download_count = resource.download_count+1
        resource.save
        send_file "#{Rails.root}/public/upload/#{resource[:attachment]}"
    end  
    def file_delete  
        resource = Resource.find(params[:r_id])  
        file_path = "#{Rails.root}/public/upload/#{resource[:attachment]}";
        if File.exist?(file_path)
            File.delete(file_path)
            resource.attachment = nil
            resource.save
        end
        redirect_to edit_resource_path(params[:r_id])
    end  
     private
    # Never trust parameters from the scary internet, only allow the white list through.
    def resource_params
      params.require(:resource).permit(:user_id,:title, :type,:content, :good, :bad,:label)
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
