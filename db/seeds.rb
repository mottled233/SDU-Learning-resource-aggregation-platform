# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'json'

# 学院数据
department = 
{
  software: Department.create(name:'软件学院'),
  math: Department.create(name:'数学院') 
}

# ==============================================================================

# 专业数据
speciality = 
{
  software: department[:software].specialities.create(name:'软件工程'),
  digital_media: department[:software].specialities.create(name:'数字媒体'),
  applied_math: department[:math].specialities.create(name:'应用数学')
}
  
# 关联专业与学院

# ==============================================================================

# 用户数据

teacher = 
{
  teacher_ml: User.create(username:'teacher1',user_role:'teacher',nickname:'许信顺',email:'teacher1@sdu.edu.com',phone_number:'13156141242',password:'123456'),
  teacher_java: User.create(username:'teacher2',user_role:'teacher',nickname:'鹿旭东',email:'teacher2@sdu.edu.com',phone_number:'13156441271',password:'123456'),
  teacher_java2: User.create(username:'teacher3',user_role:'teacher',nickname:'戴鸿君',email:'teacher3@sdu.edu.com',phone_number:'13156234271',password:'123456'),

  teacher_discrete_math: User.create(username:'teacher4',user_role:'teacher',nickname:'卢雷',email:'teacher4@sdu.edu.com',phone_number:'13256441271',password:'123456'),

}

admin = User.create(username:'admin',user_role:'admin',nickname:'管理员001',email:'w-z-y1997@163.com',phone_number:'17864154856',password:'123456',sex:"男")

network = User.create(username:'network',user_role:'student',nickname:'来自网络',email:'example@foo.com',phone_number:'17864150000',password:'123456',sex:"男")

student = 
{
  student1: User.create(username:'hello',user_role:'student',nickname:'菜鸟一只',email:'123@163.com',phone_number:'17864154809',password:'12345678',sex:"男"),
  student2: User.create(username:'mottled',user_role:'student',nickname:'梁惠欣',email:'6310@163.com',phone_number:'17864154861',password:'123456',sex:"男"),
  student3: User.create(username:'wzy',user_role:'student',nickname:'王子悦',email:'6311@163.com',phone_number:'17864150001',password:'123456',sex:"男"),
  student4: User.create(username:'scx',user_role:'student',nickname:'邵长旭',email:'6313@163.com',phone_number:'17864150002',password:'123456',sex:"男"),
  student5: User.create(username:'zxm',user_role:'student',nickname:'张晓敏',email:'6312@163.com',phone_number:'17864150003',password:'123456',sex:"男")
}

# 用户相互关注
student[:student1].followings<<([ student[:student2], student[:student3], student[:student4], student[:student5] ])
student[:student2].followings<<([ teacher[:teacher_ml], student[:student3], student[:student4] ])
# ==============================================================================

# 课程数据
course = 
{
  rails: Course.create(course_name: 'rails开发技术'),
  discrete_math: Course.create(course_name: '离散数学'),
  java: Course.create(course_name: '高级程序设计语言'),
  python: Course.create(course_name: 'python基础'),
  liner: Course.create(course_name: '线性代数'),
  high_math: Course.create(course_name: '高等数学'),
  machine_learning: Course.create(course_name: '机器学习'),
  data_structure: Course.create(course_name: '数据结构与算法基础')
}

# 关联课程与老师
course[:machine_learning].users<<(teacher[:teacher_ml])
course[:java].users<<([ teacher[:teacher_java], teacher[:teacher_java2] ])
course[:discrete_math].users<<(teacher[:teacher_discrete_math])

# 关联课程与学院
soft_course = [ course[:rails], course[:java], course[:python], course[:discrete_math], course[:liner], course[:high_math], course[:machine_learning], course[:data_structure] ]
math_course = [ course[:discrete_math], course[:high_math], course[:data_structure], course[:liner] ]
department[:software].courses<<(soft_course)
department[:math].courses<<(math_course)

# 关联专业与课程
speciality[:software].courses<<(soft_course)
speciality[:applied_math].courses<<(math_course)

# 关联用户与课程
student[:student1].selected_courses<<(soft_course)
student[:student2].selected_courses<<(soft_course)

# ==============================================================================

# 分类数据

# 顶级分类
keyword_up = 
{
  computer: Keyword.create(name:'计算机'),
  math: Keyword.create(name:'数学'),
  learning: Keyword.create(name:'学习技巧')
}

# 下级分类
keyword_down =
{
  programing: keyword_up[:computer].lowers.create(name:'编程语言'),
  frame: keyword_up[:computer].lowers.create(name:'开发框架'),
  data_structure: keyword_up[:computer].lowers.create(name:'数据结构'),
  machine_learning: keyword_up[:computer].lowers.create(name:'机器学习'),
  algorithm: keyword_up[:computer].lowers.create(name:'算法逻辑'),
  
  discrete_math: keyword_up[:math].lowers.create(name:'离散数学'),
  liner: keyword_up[:math].lowers.create(name:'线性代数'),
  higher_math: keyword_up[:math].lowers.create(name:'微积分'),
  
  learning: keyword_up[:learning].lowers.create(name:'学习方法')
} 

# 关联课程与分类
course[:rails].keywords << ([ keyword_up[:computer], keyword_down[:programing], keyword_down[:frame]])
course[:machine_learning].keywords << ([ keyword_up[:computer], keyword_down[:machine_learning], keyword_down[:liner], keyword_down[:algorithm] ])
# ....to do

# ==============================================================================

# 讨论数据
question =
{
  question1: course[:machine_learning].knowledges.create(creator: student[:student1], title:'请问SVM和感知机有什么区别？', type:'Question', content:'SVM和感知机都是线性分类器，公式都是wx=b，那么他们有什么区别？', good:0, bad:0),
  question2: course[:machine_learning].knowledges.create(creator: student[:student2], title:'梯度下降的问题', type:'Question', content:'为什么不能直接求导求出全局最低点，而非要通过梯度下降来一步步下降呢？', good:5, bad:0),
  question3: course[:machine_learning].knowledges.create(creator: student[:student1],title:'神经网络无法收敛！',type:'Question',content:'我把学习率已经调的很低了，网络模型结构是[784,30,10]，为什么不收敛呢？',good:1,bad:1)
} 

# 关联问题与分类
question[:question1].keywords << (keyword_down[:machine_learning])
question[:question2].keywords << (keyword_down[:machine_learning])
question[:question3].keywords << (keyword_down[:machine_learning])

# 用户关注问题
student[:student1].focus_contents<<(question[:question1])
student[:student2].focus_contents<<([question[:question1],question[:question2]])

# ==============================================================================

# 回复数据
reply = 
{
  relpy1: question[:question3].replies.create(creator: student[:student2], type:'Reply',content:'可能原因有很多，你说的太不具体了！',good:15,bad:1),
  reply2: question[:question2].replies.create(creator: teacher[:teacher_ml], type:'Reply',content:'因为有很多复杂的函数是无法通过直接求解得到答案的，必须通过梯度下降的方式逐步求解。',good:32,bad:1)
}

# ==============================================================================


# 添加课程专栏
file_list = ["machine_learning"]
file_list.each do |course_file|
  # 对每一课程，读取相应资源文件
  file_content=""
  File.open(File.expand_path("../origin_data/#{course_file}.course", __FILE__),"r") do |file|
    while line = file.gets
      file_content+=line
    end
  end
  # 转换为json格式，读取文章列表
  file_content = JSON::parse(file_content)
  file_content["arr"].each do |article|
    blog = Blog.create(creator: network, title: article['title'], type:'Blog', content: article['content'], good: rand(0..200), bad: rand(0..200),check_state: 1)
    blog.created_at = blog.created_at - rand(0..1000).hours
    blog.save
    course[course_file.to_sym].knowledges<<(blog)
    article['keywords'].each do |key|
      blog.keywords<<(keyword_up[key.to_sym]||keyword_down[key.to_sym])
    
    end
  end
end

# (1..100).each do |i|
#   good = rand(0..200)
#   bad = rand(0..200)
#   st = User.find(rand(1..4))
#   blogs = Blog.create(creator: st, title:"Blog "+i.to_s, type:'Blog', content: content, good: good, bad: bad)
#   blogs.good = rand(0..200)
#   blogs.bad = rand(0..200)
#   blogs.created_at = blogs.created_at - rand(0..1000)
#   course.keywords.each do |kw|
#     if rand(0..99)<25
#       blogs.keywords<<(kw)
#     end
#   end
#   blogs.courses<<(course)
#   blogs.save
#   st=User.find(rand(1..4))
#   resources = Resource.create(creator:st,title:"Resource "+i.to_s,type:'Resource',content:content,good:rand(0..200),bad:rand(0..200))
#   resources.good = rand(0..200)
#   resources.bad = rand(0..200) 
#   resources.created_at = resources.created_at - rand(0..1000)
#   course.keywords.each do |kw|
#     if rand(0..99)<25
#       resources.keywords<<(kw)
#     end
#   end
#   resources.save
  
# end
