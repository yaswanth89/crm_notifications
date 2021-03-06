Rails.application.routes.draw do
  
  get 'tasks/all'

  root 'static#home'
  get 'signup'  => 'users#new'
  get 'login'   => 'sessions#new'
  post 'login'  => 'sessions#create'
  get 'logout' => 'sessions#destroy'
  get 'my_tasks' => 'users#tasks'
  get 'au_handle' => 'static#available_users'
  get 'avalable_users/:date' => 'users#get_available_users'

  resources :tasks

  resources :users do
    member do
      get :roaster
      post :update_roaster
      get :holiday
      post :create_holiday
    end
  end
end
