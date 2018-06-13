class AddDefalutValueConstraint < ActiveRecord::Migration[5.0]
  def change
    change_column_default :courses, :review_strategy, false
  end
end
