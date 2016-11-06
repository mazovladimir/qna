require 'rails_helper'

feature 'List my questions', %q{
  In order to know my questions
  As an authenticated user
  I want to be able to list questions
} do

  given(:user) { create(:user) }
  
  scenario 'Authenticated user list question' do
    sign_in(user)

    create_question

    visit questions_path

    expect(page).to have_content 'Test question'
  end

end
