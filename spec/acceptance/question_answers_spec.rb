require 'rails_helper'

feature 'Comment for the question', %q{
  In order to know the answer
  As an authenticated user
  I want to be able to see the answer
} do

  given(:user) { create(:user) }

  scenario 'Authenticated user wants to show answer for the question' do
    sign_in(user)

    create_question

    visit questions_path

    click_on 'Show question'
    fill_in 'Body', with: 'This is my answer'
    click_on 'Comment'

    expect(page).to have_content 'This is my answer'    

  end

  scenario 'Authenticated user tries to fill the body with empty' do
    sign_in(user)

    create_question

    visit questions_path

    expect(page).to have_content 'Test question'
    click_on 'Show question'
    fill_in 'Body', with: ''
    click_on 'Comment'
    expect(page).to have_content 'Body can\'t be blank'
  end

  scenario 'Unregisterd user tries to answer the question' do
    sign_in(user)

    create_question

    visit new_question_path
    click_on 'Log Out'
    visit questions_path
 
    click_on 'Show question'
    fill_in 'Body', with: 'My new comment'
    click_on 'Comment'
    
    expect(page).to have_content 'You need to sign in or sign up before continuing'
  end
end
