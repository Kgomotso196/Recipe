Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :foods, expect: [:update]

  authenticated :user do
    root 'recipes#index', as: :authenticated_root
  end

  root 'home#index'

  resources :recipes do
    resources :recipe_foods
    member do
      get 'generate_shopping_list', to: 'recipes#generate_shopping_list'
    end
    collection do
      get 'public_recipes', to: 'recipes#public_recipes'
    end
  end
  
  resources :users
  put '/recipes/:id/toggle_public', to: 'recipes#toggle_public', as: 'toggle_recipe_public'

end
