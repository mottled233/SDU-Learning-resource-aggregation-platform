class CreateDeptCourses < ActiveRecord::Migration[5.0]
  def change
    create_table :dept_courses do |t|
      t.integer :dept_id
      t.string :course_id
      t.string :integer

      t.timestamps
    end
  end
end
