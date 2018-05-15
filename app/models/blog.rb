class Blog < Knowledge
     validates :content,presence: true,length:{minimum: 20}
     
    
    #instance method
    def to_path
      "/blogs/#{id}"
    end
end