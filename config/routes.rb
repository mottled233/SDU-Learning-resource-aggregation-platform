Rails.application.routes.draw do

 resources :departments
  get 'departments/new'

  get 'departments/show'


  root 'static_pages#home'
  
  get '/home', to: 'static_pages#home'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/logout', to: 'sessions#destroy'
  
  resources :users
  post '/users/delete/:id', to: 'users#destroy', as:"delete_user"
 
 
# start:scx's routes
 # resources :courses do
 #   resources :knowledges,:except => [:show] do
 #    get 'knowledges/:id'=>'knowledges#show',constraints:{id:/\d+/}
 #    collection do
 #      get 'question_new'
 #    end
 #   end
 #   member do
 #    get 'home'
 #    get 'blog'
 #    get 'question'
 #    get 'resource'
 #   end
 
 #   # 为了能匹配到knowledges/question_new,更细粒度的控制
 #  #get 'knowledges/:id'=>'knowledges#show',constraints:{id:/\d+/}
  
 #  # get 'knowledges/question_new' =>'knowledges#question_new',:via=>[:get,:post]
  
 # end    

 resources :courses
 resources :questions
 resources :blogs
 resources :resources
 

 get "/courses/:course_id/questions", to: "courses#questions_index", as: "course_questions"
 get "/courses/:course_id/blogs", to: "courses#blogs_index", as: "course_blogs"
 get "/courses/:course_id/resources", to: "courses#resources_index", as: "course_resources"

 get "questions/new",to: "questions#new",as:"question_new"
# 评论
 get 'knowledges/reply_show',to: "knowledges#reply_show",as: "reply_show"
# 点赞/踩
 match "/questions", to: "knowledges#add_evalute", as: "add_evalute", via: :post
 match '/questions/focus/ajax', to: 'knowledges#focus',as: "focus", via: :get
 match '/questions/unfocus/ajax', to: 'knowledges#unfocus',as: "unfocus", via: :get
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
# end:wzy's routes

end
