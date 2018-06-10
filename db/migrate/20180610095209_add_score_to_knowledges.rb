class AddScoreToKnowledges < ActiveRecord::Migration[5.0]
  def change
    add_column :knowledges, :score, :integer
    add_column :knowledges, :score_yesterday, :integer
  end
end
