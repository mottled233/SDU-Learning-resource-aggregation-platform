Rails.application.routes.draw do

 resources :departments
  get 'departments/new'

  get 'departments/show'

  get 'departments/create'

  get 'departments/edit'

  get 'departments/update'

  get 'keywords/new'

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
end
