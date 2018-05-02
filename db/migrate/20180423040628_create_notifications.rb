class CreateNotifications < ActiveRecord::Migration[5.0]
  def change
    create_table :notifications do |t|
      # must
      t.references :user, foreign_key: true, index: true # 关联用户
      t.string :notify_type # 通知类型：有新回复，更新，被删除等，定义在helper里
      t.integer :notify_entity_id # 通知实体：可通知的对象，包括课程，知识，传入id
      t.string :entity_type # 实体类型：常量定义在helper里
      
      # optional
      t.integer :with_entity_id # 比如关注课程新增一个blog，这里是blog的id
      t.string :with_entity_type # 同实体类型
      t.integer :initiator_id # 动作发起人，比如initiator为user点赞

      t.timestamps
    end
  end
end
