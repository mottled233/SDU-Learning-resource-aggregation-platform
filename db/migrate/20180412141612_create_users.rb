class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :user_role
      t.string :nickname
      t.string :email
      t.string :phone_number
      t.string :password_digest
      t.string :remember_digest
      
      t.timestamps
      
      t.index :username
      
    end
  end
end
