require_relative 'acceptance_helper'

feature 'List my questions', %q{
  In order to know my questions
  As an authenticated user
  I want to be able to list questions
} do

  let!(:user) { create(:user) }
  let!(:myquestions) { create_list(:myquestions, 5, user: user) }
  
  scenario 'Authenticated user list question' do
    sign_in(user)
    myquestions
    visit questions_path
    expect(page).to have_content 'mynewtitle1'
    expect(page).to have_content 'mynewtitle2'
    expect(page).to have_content 'mynewtitle3'
    expect(page).to have_content 'mynewtitle4'
    expect(page).to have_content 'mynewtitle5'
  end
end
