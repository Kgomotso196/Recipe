require 'rails_helper'

RSpec.feature 'Recipes Index', type: :feature do
  scenario 'User can view a list of recipes' do
    user = FactoryBot.create(:user)
    login_as(user, :scope => :user)

    FactoryBot.create(:recipe, name: 'Apple Pie', user: user)
    FactoryBot.create(:recipe, name: 'Banana Smoothie', user: user)

    visit recipes_path

    expect(page).to have_content('Apple Pie')
    expect(page).to have_content('Banana Smoothie')
  end

  scenario 'User can click on a recipe to view details' do
    user = FactoryBot.create(:user)
    login_as(user, :scope => :user)

    recipe = FactoryBot.create(:recipe, name: 'Apple Pie', user: user)

    visit recipes_path
    click_link 'Apple Pie'

    expect(page).to have_content('Apple Pie')
    expect(page).to have_content('Preparation Time:')
    expect(page).to have_content('Cooking Time:')
  end

  scenario 'User can create a new recipe' do
    user = FactoryBot.create(:user)
    login_as(user, :scope => :user)

    visit new_recipe_path
    fill_in 'Name', with: 'Chocolate Cake'
    fill_in 'Preparation time', with: 60
    fill_in 'Cooking time', with: 30
    fill_in 'Description', with: 'Delicious chocolate cake recipe'
    check 'Public'
    click_button 'Create Recipe'

    expect(page).to have_content('Impressive!')
  end

  scenario 'User can toggle the public status of a recipe' do
    user = FactoryBot.create(:user)
    login_as(user, :scope => :user)

    recipe = FactoryBot.create(:recipe, name: 'Apple Pie', user: user)

    visit recipe_path(recipe)
    click_link 'Toggle Public Status'

    expect(page).to have_content('Impressive!')
  end
end
