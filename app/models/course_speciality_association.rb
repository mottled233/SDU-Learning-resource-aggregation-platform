class CourseSpecialityAssociation < ApplicationRecord
    belongs_to :course
    belongs_to :speciality
end
