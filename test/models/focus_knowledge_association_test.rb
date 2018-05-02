require 'test_helper'

class FocusKnowledgeAssociationTest < ActiveSupport::TestCase
  def setup
    @user = users(:student1)
    @user.password = "123456"
    @knowledge = knowledges(:questions1)
    @association = focus_knowledge_associations(:one)
  end
  
  test "should be access by user" do
    assert_not @user.focus_knowledge_associations.empty?
    assert_equal @user.focus_knowledge_associations[0].id, @association.id
    assert_equal @user.focus_contents[0].id, @knowledge.id
  end
  
  test "should be access by knowledge" do
    assert_not @knowledge.focus_knowledge_associations.empty?
    assert_equal @knowledge.followers[0].id, @user.id
    assert_equal @knowledge.focus_knowledge_associations[0].id, @association.id
  end
    
  test "should not be duplicate" do
    association = FocusKnowledgeAssociation.new(knowledge_id: @knowledge.id, user_id: @user.id)
    assert_not association.save
  end
end
