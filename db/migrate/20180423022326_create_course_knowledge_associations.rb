class CreateCourseKnowledgeAssociations < ActiveRecord::Migration[5.0]
  def change
    create_table :course_knowledge_associations do |t|
      t.references :knowledge, foreign_key: true, index: true
      t.references :course, foreign_key: true, index: true
      
      t.timestamps
    end
  end
end
