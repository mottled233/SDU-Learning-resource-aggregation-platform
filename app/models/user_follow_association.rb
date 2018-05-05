class UserFollowAssociation < ApplicationRecord
  validates :followed_id, uniqueness: { scope: :following_id,
  message: "错误：重复关联" }
  belongs_to :followed, class_name: :User
  belongs_to :following, class_name: :User
end
