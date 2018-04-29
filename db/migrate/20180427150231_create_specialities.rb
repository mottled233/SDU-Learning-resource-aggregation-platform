class CreateSpecialities < ActiveRecord::Migration[5.0]
  def change
    create_table :specialities do |t|
      t.string :name, index: true
      t.belongs_to :department, foreign_key: true, index: true

      t.timestamps
    end
  end
end
