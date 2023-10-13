require 'rails_helper'

RSpec.feature 'Recipe Show', type: :feature do
  scenario 'User can view details of a recipe' do
    user = FactoryBot.create(:user)
    login_as(user, :scope => :user)

    recipe = FactoryBot.create(:recipe, name: 'Apple Pie', user: user)

    visit recipe_path(recipe)

    expect(page).to have_content('Apple Pie')
    expect(page).to have_content('Preparation Time:')
    expect(page).to have_content('Cooking Time:')
  end

  scenario 'User can add recipe to shopping list' do
    user = FactoryBot.create(:user)
    login_as(user, :scope => :user)

    recipe = FactoryBot.create(:recipe, name: 'Apple Pie', user: user)

    visit recipe_path(recipe)
    click_link 'Add to Shopping List'

    expect(page).to have_content('Shopping List')
  end
end
