class CourseKnowledgeAssociation < ApplicationRecord
    validates :course_id, uniqueness: { scope: :knowledge_id,
    message: "错误：重复关联" }
    belongs_to :course
    belongs_to :knowledge
end
