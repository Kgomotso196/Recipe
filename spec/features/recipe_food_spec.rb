require 'rails_helper'

RSpec.feature 'RecipeFoods', type: :feature do
  scenario 'User can add a food to a recipe' do
    user = FactoryBot.create(:user)
    login_as(user, :scope => :user)

    recipe = FactoryBot.create(:recipe, user: user)
    food = FactoryBot.create(:food, user: user)

    visit recipe_path(recipe)
    click_link 'Add Food'
    select food.name, from: 'Food'
    fill_in 'Quantity', with: 2
    click_button 'Add Food'

    expect(page).to have_content('Ingredient successfully added.')
  end

  scenario 'User can edit the quantity of a food in a recipe' do
    user = FactoryBot.create(:user)
    login_as(user, :scope => :user)

    recipe = FactoryBot.create(:recipe, user: user)
    food = FactoryBot.create(:food, user: user)
    recipe_food = FactoryBot.create(:recipe_food, recipe: recipe, food: food, quantity: 1)

    visit recipe_path(recipe)
    click_link 'Edit', href: edit_recipe_recipe_food_path(recipe, recipe_food)
    fill_in 'Quantity', with: 3
    click_button 'Update Recipe food'

    expect(page).to have_content('Ingredient successfully updated.')
  end

  scenario 'User can remove a food from a recipe' do
    user = FactoryBot.create(:user)
    login_as(user, :scope => :user)

    recipe = FactoryBot.create(:recipe, user: user)
    food = FactoryBot.create(:food, user: user)
    recipe_food = FactoryBot.create(:recipe_food, recipe: recipe, food: food)

    visit recipe_path(recipe)
    click_link 'Remove', href: recipe_recipe_food_path(recipe, recipe_food)

    expect(page).to have_content('Ingredient successfully removed.')
  end
end
