class TestJob < ApplicationJob
  queue_as :default

  def perform(*args)
    puts "there do the work."
    puts "entity:#{args}"
  end
end
