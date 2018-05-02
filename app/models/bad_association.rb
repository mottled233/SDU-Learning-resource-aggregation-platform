class BadAssociation < ApplicationRecord
    validates :user_id, uniqueness: { scope: :knowledge_id,
    message: "错误：重复关联" }
    belongs_to :user
    belongs_to :knowledge
end
