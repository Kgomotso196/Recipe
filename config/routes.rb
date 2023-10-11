Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :foods, expect: [:update]
  # Defines the root path route ("/")
  # root "articles#index"

  root "recipes#index"
  resources :recipes do
    resources :recipe_foods
  end
  resources :users
  put '/recipes/:id/toggle_public', to: 'recipes#toggle_public', as: 'toggle_recipe_public'

  root "foods#index"
end
