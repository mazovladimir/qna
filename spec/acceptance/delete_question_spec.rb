require 'rails_helper'

feature 'Delete question', %q{
  In order to delete question
  As an authenticated user
  I want to be able to have ability to delete
} do

  given(:user) { create(:user) }
  let (:question) { create(:question, user: user) }

  scenario 'Authenticated user list question' do
    sign_in(user)

    question

    visit questions_path

    click_on 'Delete question'

    expect(page).to_not have_content 'More than 10 symbols'
  end
end
