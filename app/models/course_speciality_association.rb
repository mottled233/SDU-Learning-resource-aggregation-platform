class CourseSpecialityAssociation < ApplicationRecord
    validates :course_id, uniqueness: { scope: :speciality_id,
    message: "错误：重复关联" }
    belongs_to :course
    belongs_to :speciality
end
