Rails.application.routes.draw do
  get 'tasks/new'

  post 'tasks/create'

  get 'tasks/all'

  get 'static/home'

  root 'static#home'
  get 'signup'  => 'users#new'
  get 'login'   => 'sessions#new'
  post 'login'  => 'sessions#create'
  get 'logout' => 'sessions#destroy'
  get 'my_tasks' => 'users#tasks'
  resources :users
end
