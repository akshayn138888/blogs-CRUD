Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  
  resources :posts do 
   resources :comments, only: [:create, :destroy]
  end
  root :to => "posts#index"
end