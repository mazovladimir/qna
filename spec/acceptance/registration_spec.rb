require 'rails_helper'

feature 'User registration', %q{
  In order to be able to log in to the system
  As an user
  I want to be able to register first
} do

  given(:user) { create(:user) }

  scenario 'Registration for the user' do
    visit new_user_registration_path
    fill_in "Email", with: 'mazovladimir@gmail.com'
    fill_in "Password", with: 'password'
    fill_in "Password confirmation", with: 'password'

    click_on 'Sign up'

    expect(page).to have_content 'Welcome! You have signed up successfully.'
    expect(current_path).to eq root_path
  end

end
