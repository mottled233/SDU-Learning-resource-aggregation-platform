class SearchesController < ApplicationController
  def index
    
  end

  def result
    @results = Knowledge
    ks=params[:key][0].split(" ")
    ks.each do |keys|
      @results = @results.where(['title like ?','%'+keys+'%'])
    end
    @results = @results.paginate(:page => params[:page], :per_page => 4)
    
  end
end
