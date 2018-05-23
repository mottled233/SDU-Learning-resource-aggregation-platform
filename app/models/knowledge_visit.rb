class KnowledgeVisit < ApplicationRecord
  belongs_to :user, class_name: :User, foreign_key: :user_id
  belongs_to :knowledge, class_name: :Knowledge, foreign_key: :knowledge_id
end
