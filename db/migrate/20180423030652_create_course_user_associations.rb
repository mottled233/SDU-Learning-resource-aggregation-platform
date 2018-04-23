class CreateCourseUserAssociations < ActiveRecord::Migration[5.0]
  def change
    create_table :course_user_associations do |t|
      t.belongs_to :user, index: true
      t.belongs_to :course, index: true
      
      t.timestamps
    end
  end
end
