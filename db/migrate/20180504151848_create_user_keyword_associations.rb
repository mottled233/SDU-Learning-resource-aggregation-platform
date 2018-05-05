class CreateUserKeywordAssociations < ActiveRecord::Migration[5.0]
  def change
    create_table :user_keyword_associations do |t|
      t.belongs_to :user, index: :true
      t.belongs_to :keyword, index: :true
      t.timestamps
    end
    add_index :user_keyword_associations,
              [:user_id, :keyword_id], unique: true,name: :unique_index_on_uka
  end
end
