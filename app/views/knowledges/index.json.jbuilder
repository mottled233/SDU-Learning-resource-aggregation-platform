json.array!(@knowledges) do |knowledge|
  json.extract! knowledge, :id, :course_id, :user_id, :type, :content, :good, :bad, :reply
  json.url knowledge_url(knowledge, format: :json)
end
