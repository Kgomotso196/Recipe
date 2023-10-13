class RecipesController < ApplicationController
  before_action :set_recipe, only: %i[show edit update destroy]
  load_and_authorize_resource
  rescue_from CanCan::AccessDenied do |_exception|
    redirect_to root_path, notice: 'Access denied'
  end

  def index
    if current_user
      @recipes = current_user.recipes.includes(:recipe_foods).order(created_at: :desc)
    else
      redirect_to new_user_session_path, alert: 'Please log in to view your foods.'
    end
  end

  def show
    @recipe = Recipe.find(params[:id])
    @food_recipe = RecipeFood.where(recipe_id: @recipe.id).includes([:food])
  end

  def new
    @recipe = Recipe.new
  end

  def edit; end

  def toggle_public
    @recipe = Recipe.find(params[:id])
    @recipe.toggle!(:public)
    redirect_to @recipe
  end

  def create
    @recipe = current_user.recipes.new(recipe_params)
    respond_to do |format|
      if @recipe.save
        format.html { redirect_to @recipe, notice: 'Impressive!' }
        format.json { render :show, status: :created, location: @recipe }
      else
        format.html { render :new, notice: 'Whoops Oh Dear!' }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @recipe.update(recipe_params)
        format.html { redirect_to @recipe, notice: 'Impressive!' }
        format.json { render :show, status: :ok, location: @recipe }
      else
        format.html { render :edit, notice: 'Whoops Oh Dear!' }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # delete
  def destroy
    @recipe.destroy
    respond_to do |format|
      format.html { redirect_to recipes_url, notice: 'Impressive!' }
      format.json { head :no_content }
    end
  end

  def public_recipes
    @recipes = Recipe.where(public: true).order(created_at: :desc)
  end

  def generate_shopping_list
    @total_value = 0
    food_types = Food.all.includes(:recipe_foods).order(created_at: :desc)
    food_types.each do |food|
      # food.update_quantity
      @total_value += food.quantity * food.price
    end
    @foods = Food.where('quantity != 0')
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :description, :public, :cooking_time)
  end
end
