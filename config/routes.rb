Rails.application.routes.draw do

 resources :departments
  get 'departments/new'

  get 'departments/show'


  root 'static_pages#home'
  
  get '/home', to: 'static_pages#home'
  post '/show_speciality', to: 'static_pages#show_speciality'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/reg', to: 'users#new'
  delete '/logout', to: 'sessions#destroy'
  get '/logout', to: 'sessions#destroy'
  
  resources :users
  
  post '/users/delete/:id', to: 'users#destroy', as:"delete_user"
  get '/users/:id/config', to: 'users#edit_config', as:"edit_user_config"
  post '/users/:id/config', to: 'users#update_config', as:"update_user_config"
 
 
# start:scx's routes
 get "/resources/file_download",to: "resources#file_download",as:"resource_file_download"
 
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
# end:wzy's routes

end
