class TeachingRelationship < ApplicationRecord
  belongs_to :course
  belongs_to :user

  validates :user_role, presence: true,
            inclusion:{ in: [:teacher], message: "必须是教师用户管理课程"}
# 在users下 若user_type 是 teacher 应该有has_many :teachingRelationships
                                          # has_many :courses, through :teachingRelationships
# 在course下 应该有has_many :teachingRelationships
                  # has_many :teachers, through :teachingRelationships
                  
end
