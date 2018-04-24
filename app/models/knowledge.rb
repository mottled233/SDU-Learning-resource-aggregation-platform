class Knowledge < ApplicationRecord
  # association
  belongs_to :creator,class_name: :User, inverse_of: :creatings, foreign_key: :creator_id
  
  has_many :course_knowledge_associations
  has_many :courses, through: :course_knowledge_associations
      
  has_many :keyword_knowledge_associations
  has_many :keywords, through: :keyword_knowledge_associations
  
  has_many :replies, class_name: :Reply, inverse_of: :topic
  
  has_many :focus_knowledge_associations
  has_many :followers, through: :focus_knowledge_associations

  
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
  
<<<<<<< HEAD
  #选取最佳资源
  def Knowledge.chooseBestKnowledge(course,num)
    if course.nil?
      best_knowledge = Knowledge.order(good: :desc)[0..num-1]
    else
      # best_knowledge = Knowledge.find_by_sql("select * 
      #                                         from Knowledges as a,course_knowledge_associations as b,courses as c 
      #                                         where a.id = b.knowledge_id and b.course_id = c.id and c.id = #{ course.id }  
      #                                         order by good desc limit 0,#{num}") 
      best_knowledge = course.knowledges.order(good: :desc)[0..num-1]
    end
  end
=======
  # instance method
  def get_followers
    followers
  end
  
>>>>>>> 03c6d3a7cbf22475428692c3212a59b5c77b81b0
end
