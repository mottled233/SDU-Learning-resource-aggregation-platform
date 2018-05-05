class Reply < Knowledge
 # callbacks
 after_create :after_initial
 
 # validates
 validates :knowledge_id, presence: true
 
 # associations
 belongs_to :topic,
    class_name: :Knowledge,
    foreign_key: :knowledge_id,
    inverse_of: :replies,
    dependent: :destroy
    
 # instance methods 
 def after_initial
   self.update_attribute(:last_reply_at, self.created_at)
   master = self.topic
   flag = false
   while master.type==TYPE_REPLY do
     master = master.topic
     flag = true
   end
   unless flag&&master.type==TYPE_QUESTION
     master.update_attribute(:last_reply_at,self.last_reply_at)
   end
 end
end
