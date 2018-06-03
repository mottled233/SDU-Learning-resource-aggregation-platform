class CreateKnowledges < ActiveRecord::Migration[5.0]
  def change
    create_table :knowledges do |t|
      t.integer :creator_id
      t.integer :topic_id
      
      t.string :title
      t.string :type
      t.string :content
      t.string :attachment
      t.string :knowledge_digest      
      t.integer :good,default: 0
      t.integer :bad,default: 0

      t.integer :visit_count,default: 0
      t.integer :download_count,default: 0

      t.timestamps
    end
  end
end
