class CourseKeywordAssociation < ApplicationRecord
    validates :course_id, uniqueness: { scope: :keyword_id,
    message: "错误：重复关联" }
    belongs_to :course
    belongs_to :keyword
end
