Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  resource :session, only: [:new, :create, :destroy]
  
  resources :users, only:[:new, :create, :update,:edit]

  resources :posts do 
   resources :comments, only: [:create, :destroy]
  end
  root 'posts#index'
end