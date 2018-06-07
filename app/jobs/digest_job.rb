class DigestJob < ApplicationJob
  queue_as :default
  require 'pycall/import'
  include PyCall::Import

  def perform(*args)
    pyimport :summary
    knowledge = args[0]
    text = knowledge.content_without_html
    puts "there do the work."
    digest = summary.interface text
    knowledge.update_attribute(:digest, digest)
  end
end
