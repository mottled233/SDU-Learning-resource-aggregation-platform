class UserKeywordAssociation < ApplicationRecord
  
  validates :user_id, uniqueness: { scope: :keyword_id,
  message: "错误：重复关联" }
  belongs_to :user
  belongs_to :keyword
  
end
