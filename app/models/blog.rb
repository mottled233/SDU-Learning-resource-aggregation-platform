class Blog < Knowledge
     validates :content,presence: true,length:{minimum: 20}
end