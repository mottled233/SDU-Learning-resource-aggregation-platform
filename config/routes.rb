Rails.application.routes.draw do
  get 'departments/new'

  get 'departments/show'

  get 'departments/create'

  get 'departments/edit'

  get 'departments/update'

  get 'keywords/new'

  root 'static_pages#home'
  
  get 'static_pages/home'
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
