class AddLastCheckTimeToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :last_check_time, :datetime
  end
end
