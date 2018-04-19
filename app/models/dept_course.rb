class DeptCourse < ApplicationRecord
#   课程隶属关系 课程与专业一对多
  belongs_to :course
  belongs_to :department
end
