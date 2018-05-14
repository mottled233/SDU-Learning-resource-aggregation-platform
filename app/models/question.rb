class Question < Knowledge
    validates :content,presence: true,length:{maximum: 200}
end
