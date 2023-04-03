Rails.application.routes.draw do

  get 'posts/index'
  get 'posts/new'
  get 'posts/show'
  get 'posts/edit'
  root 'users#index'
  get 'users/new'=>'users#new', as:'users_new'
  post'users/create'=>'users#create'
  get 'users/edit'=>'users#edit',as:'users_edit'
  delete 'users/destoy'=>'users#destroy',as: 'users_destroy'
  get 'users/:id'=>'users#show',as:'users_show'
  get 'sessions/new'=>'sessions#new', as:'sessions_new'
  delete'sessions/destoy'=>'sessions#destroy',as: 'sessions_destroy'
  post 'sessions/create'=>'sessions#create', as:'sessions_create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
