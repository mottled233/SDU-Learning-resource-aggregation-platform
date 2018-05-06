require 'test_helper'

class KnowledgeTest < ActiveSupport::TestCase
  
  test "should automatic set last_reply_at and like_count" do
    q = Question.create(user_id: users(:student1).id,
                    title: :test_question,content:"hhh")
    assert_not q.last_reply_at.nil?
    assert_not q.good.nil?
    assert_not q.bad.nil?
    assert_equal q.type, "Question"
    
    assert_not knowledges(:questions1).last_reply_at.nil?
  end
  
  
end
