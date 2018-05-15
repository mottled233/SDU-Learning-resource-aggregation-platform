class Reply < Knowledge
 # callbacks
 after_create :after_initial
 
 # validates
 validates :knowledge_id, presence: true
 validates :content,presence: true,length:{maximum: 200}
 # associations
 belongs_to :topic,
    class_name: :Knowledge,
    foreign_key: :knowledge_id,
    inverse_of: :replies,
    dependent: :destroy
    
 # instance methods 
 def after_initial
   master = self.topic
   flag = false
   while master.type==TYPE_REPLY do
     master.update_attribute(:last_reply_at,self.created_at)
     master = master.topic
     flag = true
   end
   unless flag&&master.type==TYPE_QUESTION
     master.update_attribute(:last_reply_at,self.created_at)
   end
 end
 
 def ancestor
  master = self.topic
  while master.type==TYPE_REPLY do
    master = master.topic
  end
  master
 end
 
 def to_path
  self.ancestor.to_path
 end
end
