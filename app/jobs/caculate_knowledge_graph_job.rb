class CaculateKnowledgeGraphJob < ApplicationJob
  queue_as :default
  require "rjb"

  def perform(*args)
    # Do something later
    Rjb::load("jars/aprioriAll_fat.jar");  
    graph_caculator = Rjb::import("main.main.aprioriAll.GraphCalculator");  
    file_path = graph_caculator.new_with_sig('Ljava.lang.String;','./jars/');
    result = graph_caculator.generate(file_path);
    # File.open("./jars/result.txt", "w+") do |aFile|
    #   puts result
    # end
    recomends = "";
    
    File.open("./jars/result.txt","r") do |file|  
      while line = file.gets  
        recomends = recomends + line
      end  
    end  
    recommends = result.split("="*30)
    for i in 0..(recomends.size-1)
      @user = User.find(i).recommend = recommends[i+1]
      @user.save()
    end
  end
end
