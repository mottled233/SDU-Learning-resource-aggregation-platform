class Resource< Knowledge
    validates :content,presence: true
    
    # instance methods
    def to_path
      "/resources/#{id}"
    end
end