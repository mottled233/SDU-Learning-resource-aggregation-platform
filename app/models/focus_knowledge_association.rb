class FocusKnowledgeAssociation < ApplicationRecord
    belongs_to :followers, class_name: :User, foreign_key: :user_id
    belongs_to :focus_contents, class_name: :Knowledge, foreign_key: :knowledge_id
end
