class CreateKnowledges < ActiveRecord::Migration[5.0]
  def change
    create_table :knowledges do |t|
      t.integer :creator_id
      t.integer :topic_id
      
      t.string :title
      t.string :type
      t.string :content
      t.string :attachment
      
      t.integer :good
      t.integer :bad

      t.timestamps
    end
  end
end
