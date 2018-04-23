class CreateCourseKeywordAssociations < ActiveRecord::Migration[5.0]
  def change
    create_table :course_keyword_associations do |t|
      t.references :knowledge, foreign_key: true, index: true
      t.references :keyword, foreign_key: true, index: true
      
      t.timestamps
    end
  end
end
