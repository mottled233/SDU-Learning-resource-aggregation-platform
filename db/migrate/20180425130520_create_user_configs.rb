class CreateUserConfigs < ActiveRecord::Migration[5.0]
  def change
    create_table :user_configs do |t|
      t.references :user, foreign_key: true, index: true
      # json string, include attributes(all is boolean type) below:
      # Resource, Blog, Question
      t.string :courses_notification_config
      
      # json string, include attributes(all is boolean type) below:
      # Reply
      t.string :knowledges_notification_config
      
      
      t.timestamps
    end
  end
end
