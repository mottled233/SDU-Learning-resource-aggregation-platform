class Knowledge < ApplicationRecord
  # association
  has_and_belongs_to_many :course
  belongs_to :creator,class_name: :User, inverse_of: :creatings, foreign_key: :creator_id
  
  has_many :replies, class_name: :Reply, inverse_of: :topic
  
  has_and_belongs_to_many :followers,
    class_name: :User,
    foreign_key: :knowledge_id,
    association_foreign_key: :user_id
    
  has_and_belongs_to_many :keywords
  
  # class method
  def self.inherited(child)
      child.instance_eval do
        def model_name
          Knowledge.model_name
        end
      end
    super
  end
  def Knowledge.get_all_entry(entry_type)
    Knowledge.where(:type => entry_type).all
  end
end
