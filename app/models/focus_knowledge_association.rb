class FocusKnowledgeAssociation < ApplicationRecord
    belongs_to :follower, class_name: :User, foreign_key: :user_id
    belongs_to :focus_content, class_name: :Knowledge, foreign_key: :knowledge_id
end
