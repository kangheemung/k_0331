Rails.application.routes.draw do
  
  root 'static_pages#home'
  get 'static_pages/help'=>'static_pages#help',as:'help'
  get 'static_pages/about'=>'static_pages#about',as:'about'
  
  get 'posts/index'=>'posts#index',as:'p_index'
  get 'posts/new'=>'posts#new',as:'p_new'
  post'posts/create'=>'posts#create',as:'p_create'
  get 'posts/edit' => 'posts#edit',as:'p_edit'
  get 'posts/show'=>'posts#show',as:'p_show'
  
  
  get 'users/index'=>'users#index',as:'users_index'
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
