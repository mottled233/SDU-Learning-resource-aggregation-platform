class SearchesController < ApplicationController
  def index
    
  end

  def result
    @results = Knowledge
    if (params[:select] and params[:select][:find])
      if (params[:select][:find]=='User')
        
      elsif (params[:select][:find]!='All')
        @results = @results.where(['type = ?',params[:select][:find]])
      end
    end
    ks=params[:key][0].split(" ")
    ks.each do |keys|
      @results = @results.where(['title like ?','%'+keys+'%'])
    end
    @result2 = []
    ks.each do |keys|
      if Keyword.find_by('name',keys)
        @result2 = @result2 | Keyword.find_by('name',keys).knowledges
      end
    end
    @results = @results | @result2
    if (params[:select] and params[:select][:sort])
      case params[:select][:sort]
        when "time"
          @results = @results.order(created_at: :desc)
        when "nice"
          @results = @results.order("good - bad DESC")
      end
    end
    
    @results = @results.paginate(:page => params[:page], :per_page => 4)
    
  end
end