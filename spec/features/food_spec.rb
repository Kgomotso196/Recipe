require 'rails_helper'

RSpec.feature 'Foods', type: :feature do
  let(:user) { User.create(name: 'ake', email: 'akezeth@example.com', password: 'password') }

  before do
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'password'
    click_button 'Log in'
  end

  scenario 'User navigates to the new food item form' do
    visit foods_path

    click_link 'New Food'

    expect(page).to have_content('New Food')
    expect(page).to have_field('Name')
    expect(page).to have_field('Price')
    expect(page).to have_field('Quantity')
  end

  scenario 'User creates a new food item' do
    visit new_food_path
    fill_in 'Name', with: 'Apple'
    fill_in 'Price', with: '2'
    fill_in 'Quantity', with: '1'
    click_button 'Add Food'

    expect(page).to have_content('Apple')
    expect(page).to have_content('2')
  end
end
