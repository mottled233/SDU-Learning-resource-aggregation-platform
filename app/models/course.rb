class Course < ApplicationRecord
  belongs_to :department
  # has_many :teacher_relationships 
  # has_many:teachers,:through => :teacher_relationships 
  has_many:knowledges
end
