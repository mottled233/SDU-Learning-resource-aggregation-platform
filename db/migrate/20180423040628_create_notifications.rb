class CreateNotifications < ActiveRecord::Migration[5.0]
  def change
    create_table :notifications do |t|
      t.references :user, foreign_key: true, index: true
      t.string :notify_type
      t.integer :notify_entity_id
      t.string :entity_type

      t.timestamps
    end
  end
end
