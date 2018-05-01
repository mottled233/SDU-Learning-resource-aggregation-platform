class KeywordRelationship < ApplicationRecord
    validates :higher_id, uniqueness: { scope: :lower_id,
    message: "错误：重复关联" }
    belongs_to :higher, class_name: :Keyword
    belongs_to :lower, class_name: :Keyword 
end
