class FocusKnowledgeAssociation < ApplicationRecord
    validates :user_id, uniqueness: { scope: :knowledge_id,
                            message: "出错：重复关联" }
    belongs_to :user, class_name: :User, foreign_key: :user_id
    belongs_to :knowledge, class_name: :Knowledge, foreign_key: :knowledge_id
end
