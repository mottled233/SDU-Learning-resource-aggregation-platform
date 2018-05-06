class AddLastReplyAtToKnowledges < ActiveRecord::Migration[5.0]
  def change
    add_column :knowledges, :last_reply_at, :datetime
    rename_column :knowledges, :topic_id, :knowledge_id
    rename_column :knowledges, :creator_id, :user_id
  end
end
