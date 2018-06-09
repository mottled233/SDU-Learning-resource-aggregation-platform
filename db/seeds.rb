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
  teacher_data_structure: User.create(username:'teacher5',user_role:'teacher',nickname:'郭凤华',email:'teacher5@sdu.edu.com',phone_number:'13176234271',password:'123456'),
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
  rails: Course.create(course_name: 'rails开发技术', introduction: '<p>讲授设计可持久化软件的基础知识，利用敏捷开发技术以及 Ruby on Rails 来开发云服务 (SaaS)。 学生们将了解 SaaS 对抗成品软件的新挑战和机遇。他们将了解并将基础编程技术应用于一个简单的 SaaS 应用的设计、开发、测试及公共云部署。学生们将使用同类最佳的工具，支持行为驱动设计、用户故事、测试驱动开发、快速及结对编程等现代开发技术。学生们将学习如何利用元程序设计和反射机制等现代编程语言特性提高编程效率和代码可维护性。 </p>'),
  discrete_math: Course.create(course_name: '离散数学', introduction: '<p>离散数学是计算机学科的经典核心基础课程。课程内容主要包括集合论，数理逻辑，关系理论，图论相关内容，为进一步学习计算机科学的基本理论和方法以及之后的专业课打下良好的基础。通过这门课程的学习，将会培养学生的抽象思维能力，逻辑推理能力，缜密概括能力以及分析和解决实际问题的能力。</p><p>离散数学的学习，为其后续课程（如数据结构、操作系统、计算机网络、编译理论、数字逻辑理论、数据库系统、算法分析、系统结构、人工智能等）的学习打下坚实的理论基础。</p><p>这门课程的理论性较强，知识点比较多，但均“有迹可循，有法可依”，因而完成这门课程的学习并非很难。</p>'),
  java: Course.create(course_name: '高级程序设计语言', introduction: '<p>    “高级语言程序设计”类课程面向无编程基础的学生，培养其运用编程语言解决实际问题的编程能力，使学生掌握一门编程语言的基本语法、语句、控制结构以及结构化程序设计的基本思想和方法，了解基本的算法和数据结构、良好的程序设计风格，具备熟练使用一门编程语言分析和解决实际问题的能力，从而无论以后在学习、工作中使用什么语言编程，都能灵活应用这些思想和方法，为进一步学习其他专业课程和今后从事软件开发工作打下坚实的基础。</p>'),
  python: Course.create(course_name: 'python基础', introduction: '<p>     Python [paɪθən] 语言，由Guido van Rossum大牛在1990年发明，它是当今世界最受欢迎的计算机编程语言，也是一门对大多数人“学了能用、学了有用、学会能久用”的计算生态语言。</p><p>    本课程是一门体现大学水平的Python 语言入门课程，采用“理解和运用计算生态”为教学理念，面向Python零基础学习者，不要求学习者有任何编程基础。本课程将帮助大家快速学习Python语言，高效编写程序，掌握利用计算机解决问题的基本方法和过程。</p>'),
  liner: Course.create(course_name: '线性代数', introduction: '<p>本课程主要讨论有限维线性空间的线性理论与方法，具有较强的逻辑性、抽象性与广泛的实用性，尤其在计算机日益普及的今天，解大型线性方程组、求矩阵的特征值等已经成为技术人员经常遇到的课题。因此，本课程所介绍的方法广泛地应用于各个学科。</p><p>通过本课程的学习，使学习者获得应用科学中常用的矩阵方法，线性方程组、二次型等理论及其有关的基础知识，并具有熟练的矩阵运算能力和用矩阵方法解决一些实际问题的能力，从而为学习后继课程及进一步扩大数学知识面、提高数学素养奠定必要的基础。</p>'),
  high_math: Course.create(course_name: '高等数学', introduction: '<p>在当今科技飞速发展，特别是计算机科学及其应用日新月异的时代，数学科学已渗透到各个科技领域，学习任何一门科学都要用到许多数学知识，而其中最基本的则是微积分。高等数学微积分是非数学各专业的一门必修课，学习任何一门近代数学或工程技术都必须先学微积分。</p> <p>   通过本课程的学习不但可以使学生了解微积分的起源、领会基本概念、基本思想和基本运算方法，更重要的是培养学生抽象思维、逻辑推理能力，尤其是用数学的意识和能力。通过本课程的学习也可以为后续课程打下坚实的基础。</p>'),
  machine_learning: Course.create(course_name: '机器学习', introduction: '<p>机器学习课程系统介绍进行机器智能所必须了解与掌握的专业知识，重点介绍机器学习的基本概念、基本算法、设计原理、设计方法与评价分析方法，主要内容包括机器学习的数学基础、经常使用的算法、定理以及应用等。本课程的任务是要在全局和整体的角度系统地理解和掌握机器学习的基本算法，建立定量分析的概念，培养用机器学习方法解决实际智能问题的能力。</p>'),
  data_structure: Course.create(course_name: '数据结构与算法基础', introduction: '<p>从本质上讲，数据结构属于编程类的课程，是程序设计语言课程的进阶篇。首先，程序是对数据的操作，由输入产生输出。对于比较复杂的数据，就需要从数据结构的角度来组织和存储数据，如采用数组还是链表存储结构更加高效；另外，对于比较复杂的数据操作，就需要采用一些特定的数据结构来求解，如判断一个表达式中的括号是否匹配，就需要采用栈来处理。所以数据结构课程中讲解人们在软件开发中常见的各种数据结构，并从逻辑结构到存储结构，再到运算算法设计3个层面加以学习。</p><p>程序设计解决问题往往有多种方法，且不同方法之间的效率可能相差甚远。程序的时间和空间效率，不仅跟数据的组织方式有关，也跟处理流程的巧妙程度有关。本课程将介绍有关数据组织、算法设计、时间和空间效率的概念和通用分析方法，帮助学生学会数据的组织方法和一些典型算法的实现，能够针对问题的应用背景分析，选择合适的数据结构，从而培养高级程序设计技能。</p>')
}

# 关联课程与老师
course[:machine_learning].users<<(teacher[:teacher_ml])
course[:java].users<<([ teacher[:teacher_java], teacher[:teacher_java2] ])
course[:discrete_math].users<<(teacher[:teacher_discrete_math])
course[:data_structure].users<<(teacher[:teacher_data_structure])

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
file_list = ["java", "machine_learning","discrete_math", "python", "data_structure"]
file_list.each do |course_file|
  # 对每一课程，读取相应资源文件
  file_content=""
  File.open(File.expand_path("../blog_origin_data/#{course_file}.json", __FILE__),"r") do |file|
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

# 添加课程资源
file_list = ["java", "machine_learning","discrete_math", "python"]
file_list.each do |course_file|
  # 对每一课程，读取相应资源文件
  file_content=""
  File.open(File.expand_path("../resource_origin_data/#{course_file}.json", __FILE__),"r") do |file|
    while line = file.gets
      file_content+=line
    end
  end
  # 转换为json格式，读取文章列表
  file_content = JSON::parse(file_content)
  file_content["arr"].each do |article|
    blog = Resource.create(creator: network, title: article['title'], type:'Resource', content: article['content'], good: rand(0..200), bad: rand(0..200),check_state: 1)
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
