Rails.application.routes.draw do
  root 'users#dashboard'
  get "signup", to: "users#new"
  get "users", to: "users#index"
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"
  resources :users, except: [:new]
end
