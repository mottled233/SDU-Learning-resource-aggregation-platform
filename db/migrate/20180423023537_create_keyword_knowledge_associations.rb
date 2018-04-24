class CreateKeywordKnowledgeAssociations < ActiveRecord::Migration[5.0]
  def change
    create_table :keyword_knowledge_associations do |t|
      t.references :knowledge, foreign_key: true, index: true
      t.references :keyword, foreign_key: true, index: true
      
      t.timestamps
    end
  end
end
