class AddDetailAttributesToUsers < ActiveRecord::Migration[5.0]
  def change
    change_table :users do |t|
      t.string :sex
      t.integer :grade
      t.date :birthday
      t.string :user_class
      t.integer :department_id
      t.integer :speciality_id
      t.text :self_introduce
    end
  end
end
