Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "toppages#index"
  
  get "login" => "sessions#new"
  post "login" => "sessions#create"
  delete "logout" => "sessions#destroy"
  
  
  get "signup" => "users#new"
  delete "signout" => "users#destroy"
  resources :users do
    member do
      get :profile
      get :edit_profile
      patch :update_profile
      get :followings
      get :followers
    end
  end
  
  resources :relationships, only: [:create, :destroy]
  
  resources :tweets do
    collection do
      get :followings
    end
  end
  
  resources :favorites, only: [:create, :destroy]
end
