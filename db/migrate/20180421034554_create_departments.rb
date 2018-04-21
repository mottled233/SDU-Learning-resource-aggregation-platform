class CreateDepartments < ActiveRecord::Migration[5.0]
  def change
    create_table :departments do |t|
      t.string :name
      # t.string :summary 先不要了 好像不需要
      
      t.timestamps
    end
  end
end
