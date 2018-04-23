class CourseKnowledgeAssociation < ApplicationRecord
    belongs_to :course
    belongs_to :knowledge
end
