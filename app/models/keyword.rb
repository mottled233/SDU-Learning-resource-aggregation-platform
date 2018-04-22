class Keyword < ApplicationRecord
#   关联关系 属于某一课程
  has_and_belongs_to_many :courses
  has_and_belongs_to_many :knowledges
  
  has_many :higher_relationships, class_name:  "KeywordRelationship",
                                   foreign_key: "higher_id",
                                   dependent:   :destroy
                                   
  has_many :higher, through: :higher_relationships,  source: :higher
  
  has_many :lower_relationships, class_name:  "KeywordRelationship",
                                   foreign_key: "lower_id",
                                   dependent:   :destroy
                                   
  has_many :lower, through: :lower_relationships,  source: :lower
end
