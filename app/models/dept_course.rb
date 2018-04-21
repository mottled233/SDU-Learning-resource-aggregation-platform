class DeptCourse < ApplicationRecord
#   课程隶属关系 课程与专业一对多
# 一对多关系采用has_many来实现，不是:through 所以不需要这个表 
# 只需要在department model里声明has_many :courses,在course的迁移文件中标注belongs_to
  # belongs_to :course
  # belongs_to :department
end
