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
  question2: course[:machine_learning].knowledges.create(creator: student[:student2], title:'梯度下降的问题', type:'Question', content:'为什么不能直接求导求出全局最低点，而非要通过梯度下降来一步步下降呢？', good:0, bad:0),
  question3: course[:machine_learning].knowledges.create(creator: student[:student1],title:'神经网络无法收敛！',type:'Question',content:'我把学习率已经调的很低了，网络模型结构是[784,30,10]，为什么不收敛呢？',good:1,bad:1),

  question4: course[:python].knowledges.create(creator: student[:student1],title:'你是如何自学 Python 的？',type:'Question',content:'我该怎么自学 Python 呢？',good:1,bad:10),
  question5: course[:python].knowledges.create(creator: student[:student1],title:'你都用 Python 来做什么？',type:'Question',content:'发现很多人都在学习 Python ，但是没有明确的说明可以做什么，主流的功能是什么？想知道目前利用 Python 开发的都在干什么？',good:2,bad:9),
  question6: course[:python].knowledges.create(creator: student[:student1],title:'知乎上这么多推崇学 Python 入IT 行的，如果他们学完 Python这一套找不到工作怎么办？',type:'Question',content:'Python 的岗位本来就比较少，而且大部分都对经验要求比较高，没有什么初级岗位啊<br/>我说的学Python当然不只是学语言，既然说的是学Python入IT坑，入坑当然是学全套，但我个人认为很多人学完全套还是找不到工作的，尤其是非北上广城市，职位数量少，要求反而比一线城市更高，我个人对这些人转行不看好，欢迎指正。',good:3,bad:8),
  question7: course[:python].knowledges.create(creator: student[:student1],title:'Python 有那么神吗？',type:'Question',content:'本人无编程经验，出于对学术的研究,就想学一下，结果网上有人说学 R 有人说学 Python，我打算去了解一下 Python，结果好像看到一个新世界了， Python 在他们口中好像无所不能，究竟这里面是个什么情况呢？',good:4,bad:7),
  # question7: course[:python].knowledges.create(creator: student[:student1],title:'Python 有那么神吗？',type:'Question',content:'Python 的岗位本来就比较少，而且大部分都对经验要求比较高，没有什么初级岗位啊<br/>我说的学Python当然不只是学语言，既然说的是学Python入IT坑，入坑当然是学全套，但我个人认为很多人学完全套还是找不到工作的，尤其是非北上广城市，职位数量少，要求反而比一线城市更高，我个人对这些人转行不看好，欢迎指正。',good:3,bad:8),
  question8: course[:python].knowledges.create(creator: student[:student1],title:'可以用 Python 编程语言做哪些神奇好玩的事情？',type:'Question',content:'请说明为什么这些事情适合用 Python 做',good:5,bad:6),
  question9: course[:python].knowledges.create(creator: student[:student2],title:'为什么很多人喜欢 Python？',type:'Question',content:'为什么很多人喜欢 Python？',good:6,bad:5),
  question10: course[:python].knowledges.create(creator: student[:student2],title:'未来十年Python的前景会怎样？',type:'Question',content:'未来十年，Python在中国的发展会怎样？使用Python的企业会不会越来越多？Python主要被运用的领域有哪些？使用Python的程序猿会越来越多还是越来越少呢？',good:7,bad:4),
  question11: course[:python].knowledges.create(creator: student[:student2],title:'Python 相较于Java 而言，有什么优势？',type:'Question',content:'Python 相较于Java 而言，有什么优势？',good:8,bad:3),
  question12: course[:python].knowledges.create(creator: student[:student2],title:'关于 Python 的经典入门书籍有哪些？',type:'Question',content:'适合完全没有编程基础的新手使用。',good:9,bad:2),
  question13: course[:python].knowledges.create(creator: student[:student3],title:'怎么样才算是精通 Python？',type:'Question',content:'当初学习 Python 的时候，看见各种招聘要求写着 “精通 Python 语言”。所以才问了这样一个问题，求教大家。过去一年多了，收到了很多回答，也看到了很多想法。',good:10,bad:1),
  
  question14: course[:java].knowledges.create(creator: student[:student1],title:'Java 学习线路图是怎样的？',type:'Question',content:'新手该如何一步步的学习 Java？',good:10,bad:1),
  question15: course[:java].knowledges.create(creator: student[:student3],title:'java中的<<是什么意思?',type:'Question',content:'是移位吗，移位又是什么意思',good:10,bad:1),
  question16: course[:java].knowledges.create(creator: student[:student2],title:'JAVA什么是异常',type:'Question',content:'什么是异常，为什么要进行异常处理？异常的处理机制是怎样的?',good:10,bad:1),
  question17: course[:java].knowledges.create(creator: student[:student2],title:'java中如何实现构造方法的调用',type:'Question',content:'请先文字简述，后举个简单例子',good:10,bad:5),
  question18: course[:java].knowledges.create(creator: student[:student2],title:'java 中线程是什么东东？？',type:'Question',content:'在JAVA中线程到底起到什么作用',good:10,bad:5),
  question19: course[:java].knowledges.create(creator: student[:student3],title:'java的IO类那么多，应该掌握哪几个',type:'Question',content:'java的IO类那么多，怎么记得住，应该掌握哪几个，请高手说说',good:20,bad:5)
  

} 

# 关联问题与分类
question[:question1].keywords << (keyword_down[:machine_learning])
question[:question2].keywords << (keyword_down[:machine_learning])
question[:question3].keywords << (keyword_down[:machine_learning])

question[:question4].keywords << (keyword_down[:programing])
question[:question5].keywords << (keyword_down[:programing])
question[:question6].keywords << (keyword_down[:programing])
question[:question7].keywords << (keyword_down[:programing])
question[:question8].keywords << (keyword_down[:programing])
question[:question9].keywords << (keyword_down[:programing])
question[:question10].keywords << (keyword_down[:programing])
question[:question11].keywords << (keyword_down[:programing])
question[:question12].keywords << (keyword_down[:programing])
question[:question13].keywords << (keyword_down[:programing])
question[:question14].keywords << (keyword_down[:programing])
question[:question15].keywords << (keyword_down[:programing])
question[:question16].keywords << (keyword_down[:programing])
question[:question17].keywords << (keyword_down[:programing])
question[:question18].keywords << (keyword_down[:programing])
question[:question19].keywords << (keyword_down[:programing])

# 用户关注问题
student[:student1].focus_contents<<(question[:question1])
student[:student2].focus_contents<<([question[:question1],question[:question2]])

# ==============================================================================

# 回复数据
reply = 
{
  relpy1: question[:question3].replies.create(creator: student[:student2], type:'Reply',content:'可能原因有很多，你说的太不具体了！',good:15,bad:1),
  reply2: question[:question2].replies.create(creator: teacher[:teacher_ml], type:'Reply',content:'因为有很多复杂的函数是无法通过直接求解得到答案的，必须通过梯度下降的方式逐步求解。',good:32,bad:1),
  
  #question4-11,一人一条回复
  reply3: question[:question4].replies.create(creator: student[:student4], type:'Reply',content:'这里强烈推荐Yupeng Jiang博士撰写的《三天搞定Python基本功》，只用三天时间可以了解Python数据分析的广度和所涉及的概念，是诚意之作，十分难得！因原文是用英文写成，给英国伦敦大学学院的本科生、研究生上课用的。我将其翻译成了中文，便于自己将来快速复习用。在征得jiang博士的同意后，分享给大家。',good:32,bad:1),
  reply4: question[:question5].replies.create(creator: student[:student4], type:'Reply',content:'python能做的有很多，我这里之阐述我自学的数据分析的内容，这也是我学习利用python进行数据分析的过程，如果要看实践可以直接看项目篇数据分析中常用的软件是jupyter notebook，而应用这个软件最方便的方法就是anaconda。具体的anaconda操作方法这篇文章讲述的比较详细就不多加叙述了。',good:32,bad:1),
  reply5: question[:question6].replies.create(creator: student[:student4], type:'Reply',content:'放心，学Python不会找不到工作。找不到工作的话说明你只学了Python。',good:32,bad:1),
  reply6: question[:question7].replies.create(creator: student[:student3], type:'Reply',content:'看你是要把 Python 用在什么领域？答主自己做 DevOps，常用的是 Ansible/SaltStack（ansible批量部署的问题？、ansible使用密钥短语的问题? ），有时也会写点爬虫（Python 爬虫进阶？、大家都用python写过哪些有趣的脚本? ）',good:32,bad:1),
  reply7: question[:question8].replies.create(creator: student[:student3], type:'Reply',content:'Python作为一种应用极为广泛的语言，几乎在任何领域都能派上用场。想做Web有Flask/Django/Tornado；想做分布式有Celery；想做手机App有Kivy；想做数据分析有Pandas；想做可视化有Matplotlib/Seaborn/Plotly/Bokeh；想做机器学习有Tensorflow/PyTorch/MxNet……夸张一点说，几乎没有什么做不了的东西（笔芯）。',good:32,bad:1),
  reply8: question[:question4].replies.create(creator: student[:student1], type:'Reply',content:'看书啊',good:32,bad:1),
  reply9: question[:question5].replies.create(creator: student[:student1], type:'Reply',content:'面部识别',good:32,bad:1),
  reply10: question[:question6].replies.create(creator: student[:student1], type:'Reply',content:'入行!=找工作零基础学Python=零基础学钢琴，难道1个月学会了弹小星星就能找到工作吗？',good:32,bad:1),
  # #回复question10、11、12 没人回复
  
  # #回复question13
  reply11: reply11=question[:question13].replies.create(creator: student[:student2], type:'Reply',content:'level 1：了解基本语法<br/>这是最容易的一级，掌握了 Python 的基本语法，可以通过 Python 代码实现常用的需求，不管代码质量怎么样。',good:32,bad:1),
  reply12: question[:question13].replies.create(creator: student[:student2], type:'Reply',content:'熟悉常用 standard library 的使用',good:32,bad:1),
  reply13: question[:question13].replies.create(creator: student[:student2], type:'Reply',content:'阅读 Python 的 C 实现，掌握 Python 中各种对象的本质',good:32,bad:1),
  reply14: reply14=question[:question13].replies.create(creator: student[:student2], type:'Reply',content:'我在以前找工作的时候，曾经用过「精通X」之类的词。随着踩得坑越多，越用越感觉自己懂的太少，要学的太多了',good:32,bad:1),
  reply15: question[:question13].replies.create(creator: student[:student2], type:'Reply',content:'很少有人会说自己精通Python',good:32,bad:1),

  #回复reply11
  reply16: reply16=reply11.replies.create(creator: teacher[:teacher_java], type:'Reply',content:'感觉任何一种技术不去研究它的源码实现都不敢说自己精通了的',good:32,bad:1),
  reply17: reply11.replies.create(creator: student[:student3], type:'Reply',content:'没有你那么高的境界，不过应该是这么个过程！赞',good:32,bad:1),
  #回复reply14
  reply18: reply14.replies.create(creator: teacher[:teacher_java], type:'Reply',content:'哈哈，也对，毕竟现在IT圈的忽悠可不少',good:32,bad:1),
  reply19: reply14.replies.create(creator: student[:student3], type:'Reply',content:'做为一个不得不学那么多语言的人来说，语言上的差异已经非常小，但是每一种语言都有自己的思想，重要的是思想上的转变。',good:32,bad:1),
  #回复reply16
  reply20: reply16.replies.create(creator: student[:student1], type:'Reply',content:'很棒的回答，感觉给我指明了学习的方向，感谢答主！',good:32,bad:1),
  
  #回复qusetion14
  reply21: question[:question14].replies.create(creator: student[:student3], type:'Reply',content:'打个好基础任<br/>何语言学习都可以分成两部分：语言基础和具体开发。<br/>语言基础就是变量，函数，基本面向对象，各种语法。<br/>具体开发就是语言在具体领域的应用，这个领域的开发环境，特定的库，领域概念，开发实践等。<br/>',good:73,bad:8),
  #回复question15
  reply22: reply22=question[:question15].replies.create(creator: student[:student2], type:'Reply',content:'位移动运算符:<br/><<表示左移, 左移一位表示原来的值乘2.<br/>例如：3 <<2(3为int型) <br/>1）把3转换为二进制数字0000 0000 0000 0000 0000 0000 0000 0011， <br/>2）把该数字高位(左侧)的两个零移出，其他的数字都朝左平移2位， <br/>3）在低位(右侧)的两个空位补零。则得到的最终结果是0000 0000 0000 0000 0000 0000 0000 1100， <br/>转换为十进制是12。<br/>同理,>>表示右移. 右移一位表示除2.',good:32,bad:1),
  
  #回复question16
  reply24: question[:question16].replies.create(creator: student[:student1], type:'Reply',content:'异常通常指，你的代码可能在编译时没有错误，可是运行时会出现异常。比如常见的空指针异常。也可能是程序可能出现无法预料的异常，比如你要从一个文件读信息，可这个文件不存在，程序无法运行下去了，故程序要抓这些异常，通过异常处理机制来抛出这些异常，程序员就可以通过抛出的异常来修改代码。try{}catch{}finally{}try块中放入可能会出现异常的代码，catch块负责捕获异常，finally块负责处理一些必须执行的代码，比较关闭流等。',good:13,bad:13),
  reply25: question[:question16].replies.create(creator: student[:student3], type:'Reply',content:'异常就是程序可能会报错地方了，JAVA中一般都用try{}catch{}finally{}来进行异常处理，把可能会出现异常的代码放到try快中，如果出现异常程序就会执行catch快，如果不出现异常，就不会执行catch快。',good:3,bad:4),
  #回复question17
  reply26: question[:question17].replies.create(creator: student[:student3], type:'Reply',content:'public class Util {<br/>    public String name;<br/>    public Util(){<br/>        System.out.println("无参构造方法..");<br/>  }<br/>    public Util(String name){<br/>        this.name = name;<br/>        System.out.println("有参构造方法.."+name);<br/>    }<br/>    public static void main(String[] args) {<br/>        Util u1 = new Util();<br/>              <br/>        Util u2 = new Util("小明");<br/>    }<br/>}',good:52,bad:7),
  #回复question18
  reply27: reply27=question[:question18].replies.create(creator: student[:student3], type:'Reply',content:'线程是进程中的一个实体，是被系统独立调度和分派的基本单位，线程自己不拥有系统资源，只拥有一点在运行中必不可少的资源，但它可与同属一个进程的其它线程共享进程所拥有的全部资源。一个线程可以创建和撤消另一个线程，同一进程中的多个线程之间可以并发执行。由于线程之间的相互制约，致使线程在运行中呈现出间断性。线程也有就绪、阻塞和运行三种基本状态。 <br/> 线程是程序中一个单一的顺序控制流程.在单个程序中同时运行多个线程完成不同的工作,称为多线程.  <br/>线程和进程的区别在于,子进程和父进程有不同的代码和数据空间,而多个线程则共享数据空间,每个线程有自己的执行堆栈和程序计数器为其执行上下文.多线程主要是为了节约CPU时间,发挥利用,根据具体情况而定. 线程的运行中需要使用计算机的内存资源和CPU',good:19,bad:17),
  #回复question19
  reply30: question[:question19].replies.create(creator: student[:student3], type:'Reply',content:'IO包中绝大部分的类都是由以下四个类直接或间接继承来的<br/>InputStream OutputStream Reader 还有Writer<br/>其中InputStream和OutputStream代表输入流和输出流,也就是字节流的输入和输出,他们定义了如何读取和写入字节和字节数组,所以说基本上所有XXXInputStream和XXXOutputStream都是针对字节进行操作的<br/>比如说FileInputStream,它可以以流的形式读取一个文件,或者StringBufferInputStream,它以流的形式读取一个字符串,所有的子类都是不同领域的应用罢了<br/>而Reader和Writer是在输入输出流之上的更高级的字符级别的输入输出,称为读取器和写入器,他们直接读取和写入字符(字符串)数据而不是字节(字节数组),比如你有一个文本文件就可以使用FileReader这个类来读取里面的文本,还有PrintWriter是用来输出的写入器,System.out的那个out返回的就是一个PrintWirter的内部实现PrintOutputStream<br/>其实具体类用的比较多的就是File开头的String开头的和Object开头的,Object开头的是用来序列化读取的<br/>IO包并不难,别被吓到了,掌握好他们之间的继承关系,就可以很容易了解',good:23,bad:3),
  reply31: question[:question19].replies.create(creator: student[:student1], type:'Reply',content:'一个也不需要记,记的快忘的也快,用的时候查api,常用的熟了自然就记住了<br/>可以在熟知IO流基本原理的前提下,了解一点装饰器模式,对理解Java IO的整体架构相当有好处',good:5,bad:0),
  
  # #回复reply20
  # reply23: reply22.replies.create(creator: student[:student3], type:'Reply',content:'明白了，感谢答主！',good:0,bad:0),
  # #回复reply27
  # reply28: reply28=reply27.replies.create(creator: student[:student1], type:'Reply',content:'亲  能不能用一句比较通俗易懂的话  解释一下下    谢谢',good:0,bad:0),
  # #回复reply28
  # reply29: reply28.replies.create(creator: student[:student3], type:'Reply',content:'线程是程序中一个单一的顺序控制流程，就是执行一个程序命令的单元，比如说，QQ是一个主程序，包含了其它很多的线程，譬如聊天窗口...等等',good:2,bad:0),
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
  end
end
# 回复数据
reply = 
{
  relpy1: question[:question3].replies.create(creator: student[:student2], type:'Reply',content:'可能原因有很多，你说的太不具体了！',good:15,bad:1),
  reply2: question[:question2].replies.create(creator: teacher[:teacher_ml], type:'Reply',content:'因为有很多复杂的函数是无法通过直接求解得到答案的，必须通过梯度下降的方式逐步求解。',good:32,bad:1),
  
  #question4-11,一人一条回复
  reply3: question[:question4].replies.create(creator: student[:student4], type:'Reply',content:'这里强烈推荐Yupeng Jiang博士撰写的《三天搞定Python基本功》，只用三天时间可以了解Python数据分析的广度和所涉及的概念，是诚意之作，十分难得！因原文是用英文写成，给英国伦敦大学学院的本科生、研究生上课用的。我将其翻译成了中文，便于自己将来快速复习用。在征得jiang博士的同意后，分享给大家。',good:32,bad:1),
  reply4: question[:question5].replies.create(creator: student[:student4], type:'Reply',content:'python能做的有很多，我这里之阐述我自学的数据分析的内容，这也是我学习利用python进行数据分析的过程，如果要看实践可以直接看项目篇数据分析中常用的软件是jupyter notebook，而应用这个软件最方便的方法就是anaconda。具体的anaconda操作方法这篇文章讲述的比较详细就不多加叙述了。',good:32,bad:1),
  reply5: question[:question6].replies.create(creator: student[:student4], type:'Reply',content:'放心，学Python不会找不到工作。找不到工作的话说明你只学了Python。',good:32,bad:1),
  reply6: question[:question7].replies.create(creator: student[:student3], type:'Reply',content:'看你是要把 Python 用在什么领域？答主自己做 DevOps，常用的是 Ansible/SaltStack（ansible批量部署的问题？、ansible使用密钥短语的问题? ），有时也会写点爬虫（Python 爬虫进阶？、大家都用python写过哪些有趣的脚本? ）',good:32,bad:1),
  reply7: question[:question8].replies.create(creator: student[:student3], type:'Reply',content:'Python作为一种应用极为广泛的语言，几乎在任何领域都能派上用场。想做Web有Flask/Django/Tornado；想做分布式有Celery；想做手机App有Kivy；想做数据分析有Pandas；想做可视化有Matplotlib/Seaborn/Plotly/Bokeh；想做机器学习有Tensorflow/PyTorch/MxNet……夸张一点说，几乎没有什么做不了的东西（笔芯）。',good:32,bad:1),
  reply8: question[:question4].replies.create(creator: student[:student1], type:'Reply',content:'看书啊',good:32,bad:1),
  reply9: question[:question5].replies.create(creator: student[:student1], type:'Reply',content:'面部识别',good:32,bad:1),
  reply10: question[:question6].replies.create(creator: student[:student1], type:'Reply',content:'入行!=找工作零基础学Python=零基础学钢琴，难道1个月学会了弹小星星就能找到工作吗？',good:32,bad:1),
  # #回复question10、11、12 没人回复
  
  # #回复question13
  reply11: reply11=question[:question13].replies.create(creator: student[:student2], type:'Reply',content:'level 1：了解基本语法<br/>这是最容易的一级，掌握了 Python 的基本语法，可以通过 Python 代码实现常用的需求，不管代码质量怎么样。',good:32,bad:1),
  reply12: question[:question13].replies.create(creator: student[:student2], type:'Reply',content:'熟悉常用 standard library 的使用',good:32,bad:1),
  reply13: question[:question13].replies.create(creator: student[:student2], type:'Reply',content:'阅读 Python 的 C 实现，掌握 Python 中各种对象的本质',good:32,bad:1),
  reply14: reply14=question[:question13].replies.create(creator: student[:student2], type:'Reply',content:'我在以前找工作的时候，曾经用过「精通X」之类的词。随着踩得坑越多，越用越感觉自己懂的太少，要学的太多了',good:32,bad:1),
  reply15: question[:question13].replies.create(creator: student[:student2], type:'Reply',content:'很少有人会说自己精通Python',good:32,bad:1),

  #回复reply11
  reply16: reply16=reply11.replies.create(creator: teacher[:teacher_java], type:'Reply',content:'感觉任何一种技术不去研究它的源码实现都不敢说自己精通了的',good:32,bad:1),
  reply17: reply11.replies.create(creator: student[:student3], type:'Reply',content:'没有你那么高的境界，不过应该是这么个过程！赞',good:32,bad:1),
  #回复reply14
  reply18: reply14.replies.create(creator: teacher[:teacher_java], type:'Reply',content:'哈哈，也对，毕竟现在IT圈的忽悠可不少',good:32,bad:1),
  reply19: reply14.replies.create(creator: student[:student3], type:'Reply',content:'做为一个不得不学那么多语言的人来说，语言上的差异已经非常小，但是每一种语言都有自己的思想，重要的是思想上的转变。',good:32,bad:1),
  #回复reply16
  reply20: reply16.replies.create(creator: student[:student1], type:'Reply',content:'很棒的回答，感觉给我指明了学习的方向，感谢答主！',good:32,bad:1)
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
    blog = Blog.create(creator: network, title: article['title'], type:'Blog', content: article['content'], good: rand(0..100), bad: rand(0..10),check_state: 1)
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
    blog = Resource.create(creator: network, title: article['title'], type:'Resource', content: article['content'], good: rand(0..50), bad: rand(0..10),check_state: 1)
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
