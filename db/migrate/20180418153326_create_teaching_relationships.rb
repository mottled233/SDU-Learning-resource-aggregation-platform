class CreateTeachingRelationships < ActiveRecord::Migration[5.0]
  def change
    create_table :teaching_relationships do |t|
      t.belongs_to :teacher, index: true
      t.belongs_to :course, index: true

      t.timestamps
    end
  end
end
