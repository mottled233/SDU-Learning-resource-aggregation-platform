class Speciality < ApplicationRecord
  belongs_to :department
  
  has_many :course_speciality_associations, dependent: :destroy
  has_many :courses , through: :course_speciality_associations
end
