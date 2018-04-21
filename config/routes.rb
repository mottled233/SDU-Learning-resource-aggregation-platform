Rails.application.routes.draw do

  resources :departments
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
  delete '/logout', to: 'sessions#destroy'
  get '/logout', to: 'sessions#destroy'
  
  resources :users
  post '/users/delete/:id', to: 'users#destroy', as:"delete_user"
 
 
# start:scx's routes
 resources :courses do
    resources :knowledges, :except => [:show]
 end    
  
  # 为了能匹配到knowledges/question_new,更细粒度的控制
  get 'knowledges/:id'=>'knowledges#show',constraints:{id:/\d+/}

  get 'courses/:id/home' => 'courses#:id#home'

  get 'courses/:id/blog'=> 'courses#:id#blog'

  get 'courses/:id/question'=> 'courses#:id#question'

  get 'courses/:id/resource'=> 'courses#:id#resource'
  
  get 'knowledges/question_new' =>'knowledges#question_new',:via=>[:get,:post]
# end:scx's routes

end
