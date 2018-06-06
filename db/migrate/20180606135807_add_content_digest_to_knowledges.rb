class AddContentDigestToKnowledges < ActiveRecord::Migration[5.0]
  def change
    add_column :knowledges, :content_digest, :text
  end
end
