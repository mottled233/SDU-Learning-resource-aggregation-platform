class CourseUserAssociation < ApplicationRecord
    
    validates :user_id, uniqueness: { scope: :course_id,
    message: "错误：重复关联" }
    
    belongs_to :course
    belongs_to :user
end
