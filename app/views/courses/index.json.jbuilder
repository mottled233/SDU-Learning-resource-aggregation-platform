json.array!(@courses) do |course|
  json.extract! course, :id, :course_name, :knowledge, :teacher, :teacher_relationship, :department_id
  json.url course_url(course, format: :json)
end
