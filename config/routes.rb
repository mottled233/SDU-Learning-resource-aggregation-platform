Rails.application.routes.draw do

 resources :departments
  get 'departments/new'

  get 'departments/show'


  root 'static_pages#home'
  
  # 非资源路由
  get '/home', to: 'static_pages#home'
  post '/show_speciality', to: 'static_pages#show_speciality'
  post '/home_change', to: 'static_pages#home_change'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/reg', to: 'users#new'
  delete '/logout', to: 'sessions#destroy'
  get '/logout', to: 'sessions#destroy'
  get '/unfinish', to: 'static_pages#unfinished'
  match '/search', to: 'searches#index', as:"searches_index", via: [:get, :post]
  match '/search/res', to: 'searches#result', as:"searches_result", via: [:get, :post]
  
  # 用户资源相关路由
  resources :users do
    get 'config', on: :member,to:"users#edit_config", as:"edit_config"
    post 'config', on: :member, to: 'users#update_config', as:"update_config"
    get 'followings', on: :member
    get 'followeds', on: :member
    get 'create_following', on: :member
    get 'selected_courses', on: :member
    get 'select_course', on: :member
    get 'unselect_course', on: :member
    get 'delete_following', on: :member
    get 'creatings', on: :member
    post '/users/delete/:id', on: :member, to: 'users#destroy', as:"delete_user"
    # 用户通知
    resources :notifications, only: [:index]
  end
  
 
 
# start:scx's routes
 get "/resources/file_download",to: "resources#file_download",as:"resource_file_download"
 get "/resources/file_delete",to: "resources#file_delete",as:"resource_file_delete"
 #图片
 post "/knowledges/img_upload",to: "knowledges#img_upload",as:"img_upload"
 post "/blogs/render_keyword",to: "blogs#render_keyword",as:"render_keyword"
 post "/blogs/render_department",to: "blogs#render_department",as:"render_department"
 post "/blogs/render_spe",to: "blogs#render_spe",as:"render_spe"
 post "/blogs/render_newCourse",to: "blogs#render_newCourse",as:"render_newCourse"
 
 get "/courses/:course_id/questions", to: "courses#questions_index", as: "course_questions"
 get "/courses/:course_id/blogs", to: "courses#blogs_index", as: "course_blogs"
 get "/courses/:course_id/resources", to: "courses#resources_index", as: "course_resources"

 get "questions/new",to: "questions#new",as:"question_new"
 get "blogs/new",to: "blogs#new",as:"blog_new"
 get "resources/new",to: "resources#new",as:"resource_new"
  
# 评论
 get 'knowledges/reply_show',to: "knowledges#reply_show",as: "reply_show"
 resources :courses
 resources :questions
 resources :blogs
 resources :resources
 resources :replies
 

# 点赞/踩/关注
 match "/", to: "knowledges#add_evalute", as: "add_evalute", via: :post
 match '/focus/ajax', to: 'knowledges#focus',as: "focus", via: :get
 match '/unfocus/ajax', to: 'knowledges#unfocus',as: "unfocus", via: :get
 match '/good_add/ajax', to: 'knowledges#good_add',as: "good_add", via: :get
 match '/bad_add/ajax', to: 'knowledges#bad_add',as: "bad_add", via: :get
 match '/good_sub/ajax', to: 'knowledges#good_sub',as: "good_sub", via: :get
 match '/bad_sub/ajax', to: 'knowledges#bad_sub',as: "bad_sub", via: :get
 match '/good_add_bad_sub/ajax', to: 'knowledges#good_add_bad_sub',as: "good_add_bad_sub", via: :get
 match '/good_sub_bad_add/ajax', to: 'knowledges#good_sub_bad_add',as: "good_sub_bad_add", via: :get
 match '/good_add_show/ajax', to: 'knowledges#good_add_show',as: "good_add_show", via: :get
 match '/bad_add_show/ajax', to: 'knowledges#bad_add_show',as: "bad_add_show", via: :get
 match '/good_sub_show/ajax', to: 'knowledges#good_sub_show',as: "good_sub_show", via: :get
 match '/bad_sub_show/ajax', to: 'knowledges#bad_sub_show',as: "bad_sub_show", via: :get
 match '/good_add_bad_sub_show/ajax', to: 'knowledges#good_add_bad_sub_show',as: "good_add_bad_sub_show", via: :get
 match '/good_sub_bad_add_show/ajax', to: 'knowledges#good_sub_bad_add_show',as: "good_sub_bad_add_show", via: :get

# end:scx's routes

 get '/test', to: 'static_pages#test'
# start:wzy's routes
  resources :keywords
  resources :departments
  get 'departments/new'

  get 'departments/show'

  get 'departments/create'

  get 'departments/edit'
  


  get 'departments/update'

  get 'keywords/new'
  
  get '/admins/edit', to: 'admins#edit', as: "admin_edit"
  post '/admins/update', to: 'admins#update', as: "adminUpdate"
  get 'admins/department_manage'
  get 'admins/own_space' => 'admins#own_space'
  get 'admins/row_nav' => 'admins#row_nav'
  get 'admins/ajaxtest' => 'admins#ajaxtest'
  
  get 'admins/form_edit' => 'admins#form_edit'
  resources :admins
  
  # get 'departments/create_course_association' => 'departments#create_course_association'
  post "/departments/:id/create_course_association", to: "departments#create_course_association", as: "departments/create_course_association"
  get "/departments/:id/newcourseass", to: "departments#newcourseass", as: "departments/newcourseass"
  
  get "departments/:id/deleteCourseDeptAss/:cid", to: 'departments#deleteCourseDeptAss', as: "departments/deleteCourseDeptAss"
  
  get "courses/:id/course_departments_index", to: "courses#course_departments_index", as: "courses/course_departments_index"
  get "courses/:id/course_teachers_index", to: "courses#course_teachers_index", as: "courses/course_teachers_index"

  # post "/courses/:id/create_course_association", to: "courses#create_course_association", as: "departments/create_course_association"
  get "/courses/:id/newteacherass", to:"courses#newteacherass", as: "courses/newteacherass"
  get "/courses/:id/newdeptass", to: "courses#newdeptass", as: "courses/newdeptass"
  get "/courses/:id/deleteCourseTeacherAss/:cid", to:"courses#deleteCourseTeacherAss", as: "courses/deleteCourseTeacherAss"

  get "keywords/:hid/destory_high_association/:lid", to: 'keywords#destory_high_association', as: "keywords/destory_high_association"
  get "keywords/:hid/destory_low_association/:lid", to: 'keywords#destory_low_association', as: "keywords/destory_low_association"


  
  post "/keywords/create_association", to: "keywords#create_association", as: "keywords/create_association"
  get "newkeywordass", to: "keywords#newkeywordass", as: "keywords/newkeywordass"
  
  get "attachtocourse/:id", to: "keywords#attachtocourse", as: "keywords/attachtocourse"
  post "create_course_keyword_ass", to: "keywords#create_course_keyword_ass", as: "keywords/create_course_keyword_ass"
  
  get "teachers/new", to: "teachers#new", as:"teachers/new"
  get "teachers", to:"teachers#index", as: "teachers"
  get "teachers/:id", to:"teachers#show", as: "teacher"
  get "teachers/:id/newcourseass", to:"teachers#newcourseass", as: "teachers/newcourseass"
  get "teachers/:id/deleteCourseTeacherAss/:cid", to:"teachers#deleteCourseTeacherAss", as: "teachers/deleteCourseTeacherAss"
  # get "teachers/edit/:id", to:"teachers#edit", as: "teachers/edit"
  post "/teachers/:id/create_course_association", to: "teachers#create_course_association", as: "teachers/create_course_association"
  post "teachers/create", to:"teachers#create", as:"teachers/create"
  get "teachers/destroy/:id", to: "teachers#destroy", as:"teachers/destroy"
  
  
  get 'specialities/new'

  get "specialities/:id", to:"specialities#show", as: "speciality"

  get 'specialities/create'

  get 'specialities/edit'
  
  post "/specialities/:id/create_course_association", to: "specialities#create_course_association", as: "specialities/create_course_association"
  get "/specialities/:id/newcourseass", to: "specialities#newcourseass", as: "specialities/newcourseass"
  
  get "specialities/:id/deleteCourseDeptAss/:cid", to: 'specialities#deleteCourseDeptAss', as: "specialities/deleteCourseDeptAss"

  get 'specialities/update'

  resources :specialities
  
  get "teachers/teachers_space/:id", to: "teachers#teachers_space", as:"teachers/teachers_space"
  get "teachers/detials/:id", to: "teachers#detials", as:"teachers/detials"
  get "teachers/:tid/questions_manage/:cid", to: "teachers#questions_manage", as:"teachers/questions_manage"
  get "teachers/:tid/blogs_manage/:cid", to: "teachers#blogs_manage", as:"teachers/blogs_manage"
  get "teachers/:tid/resources_manage/:cid", to: "teachers#resources_manage", as:"teachers/resources_manage"
  
  get "teachers/upload_check/:id", to: "teachers#upload_check", as:"teachers/upload_check"
  get "teachers/:tid/blogs_check/:cid", to: "teachers#blogs_check", as:"teachers/blogs_check"
  get "teachers/:tid/resources_check/:cid", to: "teachers#resources_check", as:"teachers/resources_check"
  get "teachers/:id/accept", to:"teachers#accept", as:"accept"

  get "/teachers/ajaxnames/:id", to:"teachers#ajaxnames" 
  get "/departments/ajaxnames/:id", to:"departments#ajaxnames"  
  get "/courses/ajaxnames/:id", to:"courses#ajaxnames"
  get "/keywords/ajaxkeywordname/:id", to:"keywords#ajaxkeywordname"
  get "/keywords/ajaxkeywordnamelow/:id", to:"keywords#ajaxkeywordnamelow"
  get "/keywords/ajaxkeywordnamehigh/:id", to:"keywords#ajaxkeywordnamehigh"

# end:wzy's routes

end
