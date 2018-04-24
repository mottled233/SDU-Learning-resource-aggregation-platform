class Course < ApplicationRecord
  # associations
  has_many :course_department_associations, dependent: :destroy
  has_many :departments, through: :course_department_associations
  
  has_many :course_user_associations, dependent: :destroy
  has_many :users, through: :course_user_associations
  
  has_many :course_keyword_associations, dependent: :destroy
  has_many :keywords, through: :course_keyword_associations
  
  has_many :course_knowledge_associations, dependent: :destroy
  has_many :knowledges, through: :course_knowledge_associations
  
<<<<<<< HEAD
  
=======
  # instance methods
  def get_followers
    users.where(user_role: :student)
  end
>>>>>>> 03c6d3a7cbf22475428692c3212a59b5c77b81b0
  
end
