class AddLabelToKnowledge < ActiveRecord::Migration[5.0]
  def change
    add_column :knowledges, :label, :string # 为以后扩展留下余地 标签
  end
end
