class SearchesController < ApplicationController
  def index
    @kws = {}
  end

  def result
    if (params.include?(:key) and params[:key][0]!="")
    
      k=params[:key][0]
      k=k.gsub(/[\[_%]/,'[\1]')
      if (params.include?(:find))
        if (params[:find]=='用户')
          ks=k.split(" ")
          ks.each do |keys|
          @members = User.where(['nickname like ?','%'+keys+'%'])
        end
        @members = @members.paginate(:page => params[:page], :per_page => 10)
        else
          @results = Knowledge
          if (params[:find]=='专栏')
            @results = @results.where('type = "Blog"')
            @results = @results.where("check_state=?",1)
          elsif (params[:find]=='问题')
            @results = @results.where('type = "Question"')
          elsif (params[:find]=='资源')
            @results = @results.where('type = "Resource"')
            @results = @results.where("check_state=?",1)
          end
        end
      else
        @results = Knowledge
      end
      if (params[:find]!='用户')
        ks=k.split(" ")
        ks.each do |keys|
          @results = @results.where(['knowledges.title like ? OR knowledges.id IN (SELECT keyword_knowledge_associations.knowledge_id FROM keyword_knowledge_associations WHERE(keyword_id IN (SELECT keywords.id FROM keywords WHERE keywords.name = ?)))','%'+keys+'%',keys])
        end
        @members = User.where(['nickname = ?',k])
        if (params and params[:sort])
          case params[:sort]
            when "上传时间"
              @results = @results.order(created_at: :desc)
            when "推荐程度"
              @results = @results.order("good-bad DESC")
          end
        end
        @results = @results.paginate(:page => params[:page], :per_page => 10)
      end
    else
      redirect_to searches_index_path
    end
    
  end
end
