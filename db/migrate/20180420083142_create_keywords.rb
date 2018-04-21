class CreateKeywords < ActiveRecord::Migration[5.0]
  def change
    create_table :keywords do |t|
      t.string :name
      t.references :course, foreign_key: true
    end
  end
end
