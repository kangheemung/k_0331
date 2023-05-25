Rails.application.routes.draw do
  
 


  root 'static_pages#home'
  get '/help'=>'static_pages#help'
  get '/about'=>'static_pages#about'
  get '/contact'=> 'static_pages#contact'
  
  #get 'posts/index'=>'posts#index'
  #get 'posts/new'=>'posts#new'
  post'posts/create'=>'posts#create' ,as: 'post'
  delete 'posts/destoy'=>'posts#destroy',as: 'post_destroy'
  # 'posts/:user_id/edit' => 'posts#edit',as: 'edit_posts'
  #patch'posts/:user_id/update'=>'posts#update'
  #get 'posts/:user_id'=>'posts#show',as: 'posts'
  
  get '/users'=>'users#index',as: 'users_index'
  get '/users/new'=>'users#new',as: 'users_new'
  post'/users'=>'users#create',as: 'signup_create'
  get 'users/:id/edit'=>'users#edit',as: 'edit_user'
  patch'users/:id'=>'users#update',as: 'users'
  delete 'users/:id'=>'users#destroy',as: 'user_destroy'
  get 'users/:id'=>'users#show',as: 'user'

  get 'account_activations/edit'=>'account_activations#edit',as: 'edit_account_activation'
  get 'password_resets/new'=> 'password_resets#new',as: 'new_password_reset'
  post 'password_resets/create'=>'password_resets#create',as: 'password_resets'
  get 'password_resets/:id/edit'=>'password_resets#edit',as: 'edit_password_reset'
  patch'password_resets/:id/update'=>'password_resets#update',as: 'password_reset'
  
  
  get '/login'=>'sessions#new',as: 'login'
  delete'/logout'=>'sessions#destroy'
  post '/login'=>'sessions#create',as: 'login_create'
  
 
 
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
