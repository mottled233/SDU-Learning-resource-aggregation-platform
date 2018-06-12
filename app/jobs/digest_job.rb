class DigestJob < ApplicationJob
  queue_as :default
  require 'pycall/import'
  include PyCall::Import

  def perform(*args)
    pyimport :summary
    text = args[0]
    puts "there do the work."
    digest = summary.summary_interface text
    puts digest
  end
end
