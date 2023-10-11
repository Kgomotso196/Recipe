Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :foods, expect: [:update]
  # Defines the root path route ("/")
  # root "articles#index"
  root "foods#index"
end
