class CreateUserFollowAssociations < ActiveRecord::Migration[5.0]
  def change
    create_table :user_follow_associations do |t|
      t.integer :following_id, index: :true
      t.integer :followed_id, index: :true
      t.timestamps
    end
    add_index :user_follow_associations,
              [:following_id, :followed_id], unique: true,name: :unique_index_on_uua
  end
end
