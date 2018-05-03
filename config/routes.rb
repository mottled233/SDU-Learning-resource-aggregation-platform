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
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/reg', to: 'user#new'
  delete '/logout', to: 'sessions#destroy'
  get '/logout', to: 'sessions#destroy'
  
  resources :users
  post '/users/delete/:id', to: 'users#destroy', as:"delete_user"
 
 
# start:scx's routes

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
# 点赞/踩/关注
 match "/questions", to: "knowledges#add_evalute", as: "add_evalute", via: :post
 match '/questions/focus/ajax', to: 'knowledges#focus',as: "focus", via: :get
 match '/questions/unfocus/ajax', to: 'knowledges#unfocus',as: "unfocus", via: :get
 match '/questions/good_add/ajax', to: 'knowledges#good_add',as: "good_add", via: :get
 match '/questions/bad_add/ajax', to: 'knowledges#bad_add',as: "bad_add", via: :get
 match '/questions/good_sub/ajax', to: 'knowledges#good_sub',as: "good_sub", via: :get
 match '/questions/bad_sub/ajax', to: 'knowledges#bad_sub',as: "bad_sub", via: :get
 match '/questions/good_add_bad_sub/ajax', to: 'knowledges#good_add_bad_sub',as: "good_add_bad_sub", via: :get
 match '/questions/good_sub_bad_add/ajax', to: 'knowledges#good_sub_bad_add',as: "good_sub_bad_add", via: :get
# end:scx's routes

 get '/test', to: 'static_pages#test'
end
