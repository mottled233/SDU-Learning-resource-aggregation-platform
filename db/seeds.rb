# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
department = Department.create(name:'software')
teacher = User.create(username:'aaa',user_role:'teacher',nickname:'ttt',email:'m17864154809@163.com',phone_number:'13156141371',password:'123456')
student = User.create(username:'hello',user_role:'student',nickname:'hhh',email:'123@163.com',phone_number:'17864154809',password:'12345678')
course = Course.create(course_name: 'rails')
keyword_down = Keyword.create(name:'frame')
keyword_up = Keyword.create(name:'Ruby')
question = Question.create(creator:student,title:'firstKnowledge',type:'Question',content:'hhhhh',good:0,bad:0)
question2 = Question.create(creator:student,title:'secondQuestion',type:'Question',content:'qwrqwtwetewrte',good:0,bad:0)
question3 = Question.create(creator:student,title:'firstKnowledge',type:'Question',content:'hhhhh',good:1,bad:1)
blog = Blog.create(creator:student,title:'firstKnowledge',type:'Blog',content:'hhhhh',good:0,bad:0)
blog2 = Blog.create(creator:student,title:'secondQuestion',type:'Blog',content:'qwrqwtwetewrte',good:0,bad:0)
reply_up = Reply.create(creator:student,title:'firstReply',type:'Reply',content:'bbbbbb',good:0,bad:0)
reply_down = Reply.create(creator:student,title:'SecondReply',type:'Reply',content:'cccccc',good:0,bad:0)
speciality = department.specialities.create(name: 'Software Engineering')


teacher.create_user_config
student.create_user_config

# replies<=>knowledges
reply_up.topic = question
reply_up.creator = student
reply_up.save
# replies<=>replies
reply_down.topic = reply_up
reply_down.creator = student
reply_down.save
# keyword<=>keyword
keyword_relationship = keyword_down.higher_relationships.create
keyword_relationship.higher = keyword_up
keyword_relationship.save
# course<=>teacher
teaching_relationship = course.course_user_associations.create
teaching_relationship.user = teacher
teaching_relationship.save
# course<=>department
department_course_relationship = course.course_department_associations.create
department_course_relationship.department = department
department_course_relationship.save
# course<=>keyword
course_keyword_relationships = course.course_keyword_associations.create
course_keyword_relationships.keyword = keyword_down
course_keyword_relationships.save
# course<=>knowledge
course_knowledge_relationships = question.course_knowledge_associations.create
course_knowledge_relationships.course = course
course_knowledge_relationships.save
course_knowledge_relationships2 = question2.course_knowledge_associations.create
course_knowledge_relationships2.course = course
course_knowledge_relationships2.save
# keyword<=>knowledge
keyword_knowledge_relationships = question.keyword_knowledge_associations.create
keyword_knowledge_relationships.keyword = keyword_down
keyword_knowledge_relationships.save
# followers<=>knowledge
focus_knowledge_relationships = question.focus_knowledge_associations.create
focus_knowledge_relationships.user = student
focus_knowledge_relationships.save

course_speciality_relationship = CourseSpecialityAssociation.create(course_id: course.id, speciality_id: speciality.id)
# good = GoodAssociation.create(user_id: student.id, knowledge_id: question.id)
# bad = GoodAssociation.create(user_id: teacher.id, knowledge_id: question.id)