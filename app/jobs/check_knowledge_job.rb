class CheckKnowledgeJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
    Rjb::load("jars/check.jar")  
    check = Rjb::import("PPL");  
    check.main();
  end
end
