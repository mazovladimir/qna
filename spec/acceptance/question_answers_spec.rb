require_relative 'acceptance_helper'

feature 'Comment for the question', %q{
  In order to know the answer
  As an authenticated user
  I want to be able to see the answer
} do

  let(:user) { create(:user) }
  let!(:question) { create(:question, user: user) }

  scenario 'Authenticated user wants to show answer for the question', js: true do
    sign_in(user)
    visit questions_path
    click_on 'Show question'
    fill_in 'answer_body', with: 'This is my answer'
    click_on 'Comment'
    expect(current_path).to eq question_path(question)
    within ('.answers') do
      expect(page).to have_content 'This is my answer'
    end
  end

  scenario 'Authenticated user tries to fill the body with empty', js: true do
    sign_in(user)
    visit questions_path(question)
    expect(page).to have_content 'More than 10 symbols'
    click_on 'Show question'
    fill_in 'answer_body', with: ''
    click_on 'Comment'
    expect(page).to have_content 'Body is too short (minimum is 10 characters)'
  end

  scenario 'Unregisterd user tries to answer the question' do
    sign_in(user)
    visit new_question_path
    click_on 'Log Out'
    visit questions_path
    click_on 'Show question'
    fill_in 'answer_body', with: 'My new comment'
    click_on 'Comment'
    expect(page).to have_content 'You need to sign in or sign up before continuing'
  end
end
