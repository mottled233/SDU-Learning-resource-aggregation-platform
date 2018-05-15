class Resource< Knowledge
    validates :content,presence: true,length:{maximum: 200}
    
    # instance methods
    def to_path
      "resources/#{id}"
    end
end