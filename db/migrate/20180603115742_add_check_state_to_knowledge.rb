class AddCheckStateToKnowledge < ActiveRecord::Migration[5.0]
  def change
    add_column :knowledges, :check_state, :integer # 为以后扩展留下余地 目前是0未审核1已审核
  end
end
