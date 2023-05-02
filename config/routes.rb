Rails.application.routes.draw do
  
  root 'static_pages#home'
  get '/help'=>'static_pages#help'
  get '/about'=>'static_pages#about'
  get '/contact'=> 'static_pages#contact'
  get 'posts/index'=>'posts#index'
  get 'posts/new'=>'posts#new'
  post'posts/create'=>'posts#create'
  get 'posts/:user_id/edit' => 'posts#edit'
  patch'posts/:user_id/update'=>'posts#update'
  get 'posts/:user_id'=>'posts#show'
  
  get 'users/index'=>'users#index'
  get '/signup'=>'users#new'
  post'users/create'=>'users#create'
  get 'users/:id/edit'=>'users#edit'
  patch'users/:id/update'=>'users#update'
  delete 'users/destoy'=>'users#destroy'
  get 'users/:id'=>'users#show'
  
  get '/login'=>'sessions#new'
  delete'/logout'=>'sessions#destroy'
  post '/login'=>'sessions#create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
