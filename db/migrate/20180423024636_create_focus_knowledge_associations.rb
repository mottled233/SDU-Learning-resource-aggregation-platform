class CreateFocusKnowledgeAssociations < ActiveRecord::Migration[5.0]
  def change
    create_table :focus_knowledge_associations do |t|
      t.belongs_to :user, index: :true
      t.belongs_to :knowledge, index: :true
      
      t.timestamps
    end
    
  end
end
