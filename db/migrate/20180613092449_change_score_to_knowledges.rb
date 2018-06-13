class ChangeScoreToKnowledges < ActiveRecord::Migration[5.0]
  def change
    change_column_default :knowledges, :score, 0
    change_column_default :knowledges, :score_yesterday, 0
  end
end
