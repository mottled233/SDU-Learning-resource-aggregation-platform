class CreateCourseSpecialityAssociations < ActiveRecord::Migration[5.0]
  def change
    create_table :course_speciality_associations do |t|
      t.belongs_to :course, foreign_key: true, index: true
      t.belongs_to :speciality, foreign_key: true, index: true
      t.timestamps
    end
  end
end
