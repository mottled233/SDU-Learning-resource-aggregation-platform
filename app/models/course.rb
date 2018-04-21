class Course < ApplicationRecord
  belongs_to :departments
  has_many:teachers,:through => :teacher_relationships 
  has_many:knowledges
end
