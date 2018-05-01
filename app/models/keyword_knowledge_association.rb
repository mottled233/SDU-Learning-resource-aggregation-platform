class KeywordKnowledgeAssociation < ApplicationRecord
    validates :keyword_id, uniqueness: { scope: :knowledge_id,
    message: "错误：重复关联" }
    belongs_to :keyword
    belongs_to :knowledge
end
