require 'test_helper'

class ReplyTest < ActiveSupport::TestCase
  
  test "should auto set topic's last_reply_time" do
    
    topic = Resource.create(user_id: users(:student1).id,
                    title: :test_question,content:"hhh")
    reply1 = Reply.create(knowledge_id: topic.id, user_id: users(:student1).id,
                    title: :test_reply1,content:"hhh",created_at: Time.now+1.hour)

    topic = Resource.find(topic.id)
    
    assert_not topic.last_reply_at.nil?
    assert_not reply1.created_at.nil?
    assert topic.last_reply_at-reply1.created_at<1.second
    
    reply2 = Reply.create(knowledge_id: reply1.id, user_id: users(:student1).id,
                    title: :test_reply2,content:"hhhh",created_at: Time.now+2.hour)
    
    assert topic.last_reply_at-reply2.created_at<1.second
    assert_not reply2.created_at-reply1.last_reply_at<1.second
  end
  
  test "should do special to Question" do
    topic = Question.create(user_id: users(:student1).id,
                    title: :test_question,content:"hhh")
    reply1 = Reply.create(knowledge_id: topic.id, user_id: users(:student1).id,
                    title: :test_reply1,content:"hhh",created_at: Time.now+1.hour)
    topic = Question.find(topic.id)
    
    assert_not topic.last_reply_at.nil?
    assert_not reply1.created_at.nil?
    assert topic.last_reply_at-reply1.created_at<1.second
    
    reply2 = Reply.create(knowledge_id: reply1.id, user_id: users(:student1).id,
                    title: :test_reply2,content:"hhhh",created_at: Time.now+2.hour)
    
    assert_not reply2.created_at-topic.last_reply_at<1.second
    assert_not reply2.created_at-reply1.last_reply_at<1.second
  end
  
  test "topic association should work" do
    topic = Question.create(user_id: users(:student1).id,
                    title: :test_question,content:"hhh")
    reply1 = topic.replies.create(user_id: users(:student1).id,
                    title: :test_reply1,content:"hhh")
    assert_equal topic.replies[0], reply1
    assert_equal reply1.topic, topic
  end
  
end
