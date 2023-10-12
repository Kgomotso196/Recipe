class Ability
  include CanCan::Ability

  def initialize(user)
    if user.admin?
      can :manage, :all
    else
      can :read, :all
      can :manage, Recipe, user_id: user.id
      can :manage, RecipeFood, user_id: user.id
    end
  end
end
