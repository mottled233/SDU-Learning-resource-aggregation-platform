class AddCheckedToNotifications < ActiveRecord::Migration[5.0]
  def change
    add_column :notifications, :checked, :boolean
  end
end
