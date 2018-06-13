class AddReviewStrategyToCourses < ActiveRecord::Migration[5.0]
  def change
    add_column :courses, :review_strategy, :boolean
  end
end
