require_relative 'acceptance_helper'

feature 'Answer editing', %q{
  In order to fix mistake
  As an author of answer
  I want to be able to edit my answer
} do

  let(:user) { create(:user) }
  let!(:question) { create(:question, user: user) }
  let(:answer) { create(:answer, question: question, user: user) }

  scenario 'Unauthenticated user tries to edit question' do
    visit question_path(question)
    expect(page).to_not have_link 'Edit'
  end

  scenario 'Authenticated user sees link to Edit', js: true do
    sign_in(user)
    visit question_path(question)
    fill_in 'Body', with: 'This is my answer'
    click_on 'Comment'
    expect(current_path).to eq question_path(question)
    within '.answers' do
      expect(page).to have_link 'Edit' 
    end
  end

  scenario 'Authenticated user tries to edit answer'
  scenario 'Authenticated user tries to edit answer of another person'


end
