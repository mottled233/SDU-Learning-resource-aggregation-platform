class CreateKeywords < ActiveRecord::Migration[5.0]
  def change
    create_table :keywords do |t|
      t.string :name
<<<<<<< HEAD:db/migrate/20180421095204_create_keywords.rb
      t.belongs_to :course, foreign_key: true

=======
      
>>>>>>> a7178c160befe5ed10fb5e0ce759abaf5c1b494d:db/migrate/20180420083142_create_keywords.rb
      t.timestamps
    end
  end
end
