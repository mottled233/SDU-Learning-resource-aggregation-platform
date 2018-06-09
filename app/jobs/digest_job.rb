class DigestJob < ApplicationJob
  require 'pycall/import'
  include PyCall::Import
  
  
  queue_as :default

  def perform(*args)
    pyimport "test_call"
    puts "there do the work."
    a = test_call.cut("他来到了网易大厦")
    puts(a.class)
    p(a)
  end
end
