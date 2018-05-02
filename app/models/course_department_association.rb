class CourseDepartmentAssociation < ApplicationRecord
      
      validates :course_id, uniqueness: { scope: :department_id,
                        message: "出错：重复关联" }
      
      
      belongs_to :course
      belongs_to :department
end
