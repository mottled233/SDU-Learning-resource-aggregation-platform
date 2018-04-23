class Reply < Knowledge
 belongs_to :topic,
    class_name: :Knowledge,
    foreign_key: :topic_id,
    inverse_of: :replies
end
