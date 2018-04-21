class CreateCourses < ActiveRecord::Migration[5.0]
  def change
    create_table :courses do |t|
      t.string :course_name
      
      
      t.belongs_to :department, foreign_key: true

      t.timestamps
    end
  end
end
