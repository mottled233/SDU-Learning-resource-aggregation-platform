class KeywordRelationship < ApplicationRecord
    belongs_to :higher, class_name: :Keyword
    belongs_to :lower, class_name: :Keyword 
end
