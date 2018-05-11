class Department < ApplicationRecord

    has_many :course_department_associations, dependent: :destroy
    has_many :courses, through: :course_department_associations
    
    has_many :specialities
end
