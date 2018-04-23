class CourseKeywordAssociation < ApplicationRecord
    belongs_to :course
    belongs_to :keyword
end
