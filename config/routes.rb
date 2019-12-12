Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "users#index"
  
  get "signup" => "users#new"
  get "signout" => "users#destroy"
  resources :users
end
