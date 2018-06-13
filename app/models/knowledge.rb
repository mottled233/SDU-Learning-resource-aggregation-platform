class Knowledge < ApplicationRecord
  include KnowledgesHelper
  include ApplicationHelper
  
  # callbacks
  before_create :default_values
  def default_values
    self.visit_count=0
    self.download_count=0
  end
  
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
  def Knowledge.chooseBestKnowledge(course)
    if course.nil?
      best_knowledge = Knowledge.order(good: :desc)
    else
      best_knowledge = course.knowledges.order(good: :desc)
    end
  end

  # instance method
  def get_followers
    followers
  end
  
  def getReplies
    Reply.where(:topic => self.id).all
  end

  def getAllReplies
    layer = self.getReplies
    list = Array.new
    layer.each do |r| 
        list << r
        if !r.getReplies.nil?
            templ = r.getAllReplies
            list = list+templ
        end
    end
    list = list.sort_by{ |created_at| created_at }.reverse
    return list
  end
  
  def knowledge_digest(length=50)
    short_digest(self.content_without_html, length)
  end
  
  def content_without_html
    string = content
    string.gsub!(/[\n\\n\s]/,"")
    string.gsub!(/<pre.*?\/pre>/,"")
    string.gsub!(/<.+?>/,"")
    string
    
  end
  
  def chinese_type
    case self.type
    when TYPE_QUESTION
      "讨论"
    when TYPE_BLOG
      "专栏"
    when TYPE_RESOURCE
      "资源"
    when TYPE_REPLY
      "回复"  
    end
  end
  
  
end
