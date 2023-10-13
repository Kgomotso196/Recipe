require 'rails_helper'

RSpec.describe RecipesController, type: :request do
  let(:user) { User.new(name: 'Troos', email: 'troos@test.com', password: 'password') }

  before do
    user.skip_confirmation!
    user.save
  end

  def authenticate_user(user)
    post user_session_path, params: { user: { email: user.email, password: user.password, name: user.name } }
    follow_redirect!
  end

  describe 'GET #index' do
    it 'returns a success response if user is authenticated' do
      authenticate_user(user)
      get recipes_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET #show' do
    let(:recipe) do
      Recipe.create(name: 'Briyani', preparation_time: 30, cooking_time: 30, description: 'Briyani', public: false,
                    user_id: user.id)
    end

    it 'returns a success response' do
      authenticate_user(user)
      get recipe_path(recipe)
      expect(response).to be_successful
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      authenticate_user(user)
      get new_recipe_path
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    it 'should create a new Recipe' do
      authenticate_user(user)
      expect do
        post recipes_path,
             params: {
               recipe: {
                 name: 'Briyani',
                 preparation_time: 30,
                 cooking_time: 30,
                 description: 'Fried rice',
                 public: false,
                 user_id: user.id
               }
             }
      end.to change(Recipe, :count).by(1)
    end
  end

  describe 'GET #destroy' do
    let!(:recipe) do
      Recipe.create(name: 'recipe', preparation_time: 10, cooking_time: 20, description: 'Briyani', public: false,
                    user_id: user.id)
    end

    it 'should destroy the recipe' do
      authenticate_user(user)
      expect do
        delete recipe_path(recipe)
      end.to change(Recipe, :count).by(-1)
    end

    it 'should redirect to the recipes list' do
      authenticate_user(user)
      delete recipe_path(recipe)
      expect(response).to redirect_to(recipes_path)
    end
  end

  describe 'GET #toggle_public' do
    let!(:recipe) do
      Recipe.create(name: 'Briyani', preparation_time: 10, cooking_time: 20, description: 'Fried rice', public: false,
                    user_id: user.id)
    end
  end

  describe 'GET #shopping_list' do
    let!(:recipe) do
      Recipe.create(name: 'Briyani', preparation_time: 10, cooking_time: 20, description: 'Fried rice', public: false,
                    user_id: user.id)
    end
  end
end
