class TeachingRelationship < ApplicationRecord
  belongs_to :course
  belongs_to :user

  validates :user_role, presence: true,
            inclusion:{ in: [:teacher], message: "必须是教师用户管理课程"}

end
