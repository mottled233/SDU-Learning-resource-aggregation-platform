class CreateKnowledges < ActiveRecord::Migration[5.0]
  def change
    create_table :knowledges do |t|
      t.belongs_to :course, foreign_key: true
      t.belongs_to :user, foreign_key: true
      t.belongs_to :reply
      t.string :type
      t.string :content
      t.integer :good
      t.integer :bad

      t.timestamps
    end
  end
end
