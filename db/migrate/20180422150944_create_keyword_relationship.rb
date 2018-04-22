class CreateKeywordRelationship < ActiveRecord::Migration[5.0]
  def change
    create_table :keyword_relationships do |t|
      t.integer :higher_id, index: true
      t.integer :lower_id, index: true
    end
  end
end
