class CreateCoursesDepartments < ActiveRecord::Migration[5.0]
  def change
    create_table :courses_departments do |t|
      t.belongs_to :course, index: :true
      t.belongs_to :department, index: :true
    end
  end
end
