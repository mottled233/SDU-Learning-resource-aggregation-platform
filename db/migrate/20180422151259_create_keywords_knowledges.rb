class CreateKeywordsKnowledges < ActiveRecord::Migration[5.0]
  def change
    create_table :keywords_knowledges do |t|
      t.references :knowledge, foreign_key: true, index: true
      t.references :keyword, foreign_key: true, index: true
    end
  end
end
