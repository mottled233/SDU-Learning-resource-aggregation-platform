# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

department = Department.create(name:'软件学院')
speciality = department.specialities.create(name:'软件工程')
teacher = User.create(username:'aaa',user_role:'teacher',nickname:'ttt',email:'m17864154809@163.com',phone_number:'13156141371',password:'123456')

admin = User.create(username:'admin',user_role:'admin',nickname:'tempadmin',email:'w-z-y1997@163.com',phone_number:'17864154856',password:'123456',sex:"男")
student = User.create(username:'hello',user_role:'student',nickname:'hhh',email:'123@163.com',phone_number:'17864154809',password:'12345678',sex:"男")
student2 = User.create(username:'mottled',user_role:'student',nickname:'梁惠欣',email:'6310@163.com',phone_number:'17864154861',password:'123456',sex:"男")
course = Course.create(course_name: 'rails')
keyword_down = Keyword.create(name:'框架')
keyword_up = Keyword.create(name:'Ruby')
question = Question.create(creator:student,title:'firstKnowledge',type:'Question',content:'hhhhh',good:0,bad:0)
question2 = Question.create(creator:student,title:'secondQuestion',type:'Question',content:'qwrqwtwetewrte',good:0,bad:0)
question3 = Question.create(creator:student,title:'firstKnowledge',type:'Question',content:'hhhhh',good:1,bad:1)
blog = Blog.create(creator:student,title:'firstKnowledge',type:'Blog',content:'hhhhh',good:0,bad:0)
blog2 = Blog.create(creator:student,title:'secondQuestion',type:'Blog',content:'qwrqwtwetewrte',good:0,bad:0)
reply_up = Reply.create(creator:student,title:'firstReply',type:'Reply',content:'bbbbbb',good:0,bad:0)
reply_down = Reply.create(creator:student,title:'SecondReply',type:'Reply',content:'cccccc',good:0,bad:0)
speciality = department.specialities.create(name: 'Software Engineering')

# Create 100 blogs & resources
(1..100).each do |i|
  blogs = Blog.create(creator:student,title:"Blog "+i.to_s,type:'Blog',content:i.to_s*60,good:rand(0..200),bad:rand(0..200))
  blogs.created_at = blogs.created_at - rand(0..1000)
  blogs.save
  resources = Resource.create(creator:student,title:"Resource "+i.to_s,type:'Resource',content:i.to_s*60,good:rand(0..200),bad:rand(0..200))
  resources.created_at = resources.created_at - rand(0..1000)
  resources.save
end

# replies<=>knowledges
reply_up.topic = question
reply_up.creator = student

# replies<=>replies
reply_down.topic = reply_up
reply_down.creator = student
# keyword<=>keyword
keyword_down.highers<<(keyword_up)
# course<=>teacher
course.users<<(teacher)
# course<=>department
department.courses<<(course)
# course<=>keyword
course.keywords<<(keyword_down)
# course<=>knowledge
course.knowledges<<(question)
course.knowledges<<(question2)
# keyword<=>knowledge
question.keywords<<(keyword_down)
# followers<=>knowledge
student.focus_contents<<(question)
student2.focus_contents<<(question)
student2.focus_contents<<(question2)

course_speciality_relationship = CourseSpecialityAssociation.create(course_id: course.id, speciality_id: speciality.id)
# good = GoodAssociation.create(user_id: student.id, knowledge_id: question.id)
# bad = GoodAssociation.create(user_id: teacher.id, knowledge_id: question.id)


student.focus_keywords<<(Keyword.first)
student2.focus_keywords<<(keyword_down)

notification1 = student2.notifications.create(notify_type: :update, notify_entity_id: question.id, entity_type: :Question)
notification2 = student.notifications.create(notify_type: :update, notify_entity_id: question.id, entity_type: :Question)
UserFollowAssociation.create(followed_id: student2.id, following_id: student.id)