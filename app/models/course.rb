class Course < ApplicationRecord
  belongs_to :department
  has_many :teachingRelationships 
  has_many:teachers,class_name: :User,:through => :teachingRelationships 
  has_many:knowledges
end
