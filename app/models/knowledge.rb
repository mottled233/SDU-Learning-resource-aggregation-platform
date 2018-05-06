class Knowledge < ApplicationRecord
  include KnowledgesHelper
  # callbacks
  before_create :default_values
  
  # association
  belongs_to :creator,class_name: :User, inverse_of: :creatings, foreign_key: :user_id
  
  has_many :course_knowledge_associations
  has_many :courses, through: :course_knowledge_associations
      
  has_many :keyword_knowledge_associations
  has_many :keywords, through: :keyword_knowledge_associations
  
  has_many :replies, class_name: :Reply, inverse_of: :topic
  
  has_many :focus_knowledge_associations
  has_many :followers, through: :focus_knowledge_associations, source: :user
  
  has_many :like_user_associations, class_name: :GoodAssociation, dependent: :destroy
  has_many :like_users, through: :like_user_associations, source: :user
  
  has_many :unlike_user_associations, class_name: :BadAssociation, dependent: :destroy
  has_many :unlike_users, through: :unlike_user_associations, source: :user
  
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

  # instance method
  def get_followers
    followers
  end
  
  def getReplies
    Reply.where(:topic => self.id).all
  end
  
  def default_values
    self.last_reply_at=Time.now
    self.good = 0
    self.bad = 0
  end

end
