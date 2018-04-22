class CreateCoursesKeywords < ActiveRecord::Migration[5.0]
  def change
    create_table :courses_keywords do |t|
      t.references :course, foreign_key: true, index: true
      t.references :keyword, foreign_key: true, index: true
    end
  end
end
