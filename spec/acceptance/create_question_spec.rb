require 'rails_helper'

feature 'Create question', %q{
  In order to get answer from community
  As an authenticated user
  I want to be able to ask questions
} do

  given(:user) { create(:user) }
  
  scenario 'Authenticated user creates question' do
    sign_in(user)

    create_question

    expect(page).to have_content 'Test question'
    expect(page).to have_content 'Text tex'
  end

  scenario 'Authenticated user try to send empty form' do
    sign_in(user)

    visit questions_path
    click_on 'Ask question'
    fill_in 'Title', with: ''
    fill_in 'Body', with: ''
    click_on 'Create'

    expect(page).to have_content 'Title is too short (minimum is 10 characters)'
    expect(page).to have_content 'Body is too short (minimum is 2 characters)'
  end


  scenario 'Non-authenticated user tries to create question' do
    visit questions_path
    click_on 'Ask question'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end

end
