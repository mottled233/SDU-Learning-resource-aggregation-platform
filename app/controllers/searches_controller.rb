class SearchesController < ApplicationController
  def index
    @kws = {}
  end

  def result
    @results = Knowledge
    if (params.include?(:find))
      if (params[:find]=='用户')
        
      elsif (params[:find]=='专栏')
        @results = @results.where('type = "Blog"')
      elsif (params[:find]=='问题')
        @results = @results.where('type = "Question"')
      elsif (params[:find]=='资源')
        @results = @results.where('type = "Resource"')
      end
    end
    k=params[:key][0]
    k=k.gsub(/[\[_%]/,'[\1]')
    ks=k.split(" ")
    ks.each do |keys|
      @results = @results.where(['knowledges.title like ? OR knowledges.id IN (SELECT keyword_knowledge_associations.knowledge_id FROM keyword_knowledge_associations WHERE(keyword_id IN (SELECT keywords.id FROM keywords WHERE keywords.name = ?)))','%'+keys+'%',keys])
    end

    
    if (params and params[:sort])
      case params[:sort]
        when "上传时间"
          @results = @results.order(created_at: :desc)
        when "推荐程度"
          @results = @results.order("good DESC")
      end
    end
    
    @results = @results.paginate(:page => params[:page], :per_page => 4)
    
  end
end
