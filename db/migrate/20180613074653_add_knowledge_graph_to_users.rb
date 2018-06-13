class AddKnowledgeGraphToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :knowledge_graph, :text
  end
end
