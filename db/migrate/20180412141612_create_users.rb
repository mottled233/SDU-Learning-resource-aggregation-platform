class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :user_role
      t.string :nickname
      t.string :email
      t.string :phone_number
      
      t.timestamps
    end
  end
end
