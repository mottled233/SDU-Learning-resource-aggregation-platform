class AddRecommendToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :recommend, :string
  end
end
