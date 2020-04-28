Rails.application.routes.draw do
  get 'users/create'
  get 'users/new'
  get 'create/new'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to:"tasks#index"
  
  resources :tasks
  get 'signup', to: 'users#new'
  resources :users, only: [:new, :create]
end
