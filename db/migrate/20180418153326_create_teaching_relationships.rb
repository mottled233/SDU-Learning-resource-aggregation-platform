class CreateTeachingRelationships < ActiveRecord::Migration[5.0]
  def change
    create_table :teaching_relationships do |t|
      t.integer :teacher_id
      t.integer :course_id

      t.timestamps
    end
  end
end
