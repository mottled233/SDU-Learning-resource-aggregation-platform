Rails.application.routes.draw do

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
  delete '/logout', to: 'sessions#destroy'
  get '/logout', to: 'sessions#destroy'
  
  resources :users
  post '/users/delete/:id', to: 'users#destroy', as:"delete_user"
 
 
# start:scx's routes
  resources :knowledges, :except => [:show]
  # 为了能匹配到knowledges/question_new,更细粒度的控制
  get 'knowledges/:id'=>'knowledges#show',constraints:{id:/\d+/}

  get 'course_pages/home' =>'course_pages#home'

  get 'course_pages/question' =>'course_pages#question'

  get 'course_pages/blog' =>'course_pages#blog'

  get 'course_pages/resource' =>'course_pages#resource'
  
  get 'knowledges/question_new' =>'knowledges#question_new',:via=>[:get,:post]
# end:scx's routes

end
