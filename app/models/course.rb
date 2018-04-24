class Course < ApplicationRecord
  has_many :course_department_associations, dependent: :destroy
  has_many :departments, through: :course_department_associations
  
  has_many :course_user_associations, dependent: :destroy
  has_many :users, through: :course_user_associations
  
  has_many :course_keyword_associations, dependent: :destroy
  has_many :keywords, through: :course_keyword_associations
  
  has_many :course_knowledge_associations, dependent: :destroy
  has_many :knowledges, through: :course_knowledge_associations
end
