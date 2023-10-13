Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :foods, expect: [:update]

  root "recipes#public_recipes"
  resources :recipes do
    resources :recipe_foods
    member do
      get 'generate_shopping_list', to: 'recipes#generate_shopping_list'
    end
  end
  
  resources :users
  put '/recipes/:id/toggle_public', to: 'recipes#toggle_public', as: 'toggle_recipe_public'

end
