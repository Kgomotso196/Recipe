class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.admin?
      can :manage, :all
    else
      can :read, :all

      # Recipe Authorization
      can :manage, Recipe, user_id: user.id

      # Food Authorization
      can :manage, Food, :all
      cannot :destroy, Food do |food|
        food.user_id != user.id
      end

      # Ingredient Authorization
      cannot :destroy, Food do |food|
        food.recipe_foods.any? { |ingredient| ingredient.recipe.user_id != user.id }
      end
      can :manage, RecipeFood, user_id: user.id
    end
  end
end
