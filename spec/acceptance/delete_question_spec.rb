require_relative 'acceptance_helper'

feature 'Delete question', %q{
  In order to delete question
  As an authenticated user
  I want to be able to have ability to delete
} do

  let!(:user) { create(:user) }
  let!(:user2) { create(:user, email: 'vovka@test.com') }
  let!(:question) { create(:question, user: user) }

  scenario 'Authenticated user deletes question', js: true do
    sign_in(user)
    visit questions_path
    expect(page).to have_content 'More than 10 symbols'
    click_on 'Delete question'
    expect(page).to_not have_content 'More than 10 symbols'
  end

  scenario 'Non-Author Authenticated user deletes question', js: true do
    sign_in(user2)
    visit questions_path
    expect(page).to_not have_content 'Delete question'
  end  

  scenario 'Non-Authenticated user deletes question', js: true do
    visit questions_path
    expect(page).to_not have_content 'Delete question'
  end
end
