class KeywordKnowledgeAssociation < ApplicationRecord
    belongs_to :keyword
    belongs_to :knowledge
end
