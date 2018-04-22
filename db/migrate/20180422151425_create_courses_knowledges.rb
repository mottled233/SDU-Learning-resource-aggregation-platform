class CreateCoursesKnowledges < ActiveRecord::Migration[5.0]
  def change
    create_table :courses_knowledges do |t|
      t.references :knowledge, foreign_key: true, index: true
      t.references :course, foreign_key: true, index: true
    end
  end
end
