class CreateCourseVisits < ActiveRecord::Migration[5.0]
  def change
    create_table :course_visits do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :course, foreign_key: true
      t.integer :count

      t.timestamps
    end
  end
end
