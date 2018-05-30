class Question < Knowledge
  include ApplicationHelper
    validates :content,presence: true,length:{minimum: 1,maximum: 200}
    
    # instance methods
    def to_path
      "/questions/#{self.id}"
    end
end
