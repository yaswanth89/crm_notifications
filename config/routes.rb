Rails.application.routes.draw do
  get 'tasks/new'

  post 'tasks/create'

  get 'tasks/all'

  root 'static#home'
  get 'signup'  => 'users#new'
  get 'login'   => 'sessions#new'
  post 'login'  => 'sessions#create'
  get 'logout' => 'sessions#destroy'
  get 'my_tasks' => 'users#tasks'
  get 'reminders' => 'users#reminders'
  get 'notifications' => 'users#notifications'
  resources :users
end
