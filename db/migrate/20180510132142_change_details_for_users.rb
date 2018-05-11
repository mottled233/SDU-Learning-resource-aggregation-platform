class ChangeDetailsForUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :department, :string
    add_column :users, :speciality, :string
  end
end
