class CreateCourseDepartmentAssociations < ActiveRecord::Migration[5.0]
  def change
    create_table :course_department_associations do |t|
      t.belongs_to :course, index: :true
      t.belongs_to :department, index: :true
      
      t.timestamps
    end
  end
end
