class AddTitleFieldForKnowledges < ActiveRecord::Migration[5.0]
  def change
    add_column :knowledges,:title,:string
  end
end
