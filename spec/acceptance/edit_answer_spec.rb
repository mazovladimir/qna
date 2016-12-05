require_relative 'acceptance_helper'

feature 'Answer editing', %q{
  In order to fix mistake
  As an author of answer
  I'd like ot be able to edit my answer
} do

  let(:user) { create(:user) }
  let!(:question) { create(:question, user: user) }
  let!(:answer) { create(:answer, question: question, user: user) }
  let!(:myanswers) { create_list(:myanswers, 5, question: question, user: user) }

  scenario 'Unauthenticated user try to edit question' do
    visit questions_path
    click_on 'Show question'
    expect(page).to_not have_link 'Edit comment'
  end


  describe 'Authenticated user' do
    before do
      sign_in(user)
      visit question_path(question)
    end

    scenario 'sees link to Edit', js: true do
      within '.answers' do
        expect(page).to have_link 'Edit comment'
      end
    end

    scenario 'try to edit his answer', js: true do
      click_on 'Edit comment', match: :first
      within '.answers' do
        fill_in 'edit-body', with: 'edited answer'
        click_on 'Save'

        expect(page).to_not have_content answer.body
        expect(page).to have_content 'edited answer'
        expect(page).to_not have_selector 'textarea'
      end
    end

    scenario 'sets answer as best', js: true do
      expect(page).to have_content 'mynewbodygood16'
      expect(page).to have_content 'mynewbodygood17'
      expect(page).to have_content 'mynewbodygood18'
      expect(page).to have_content 'mynewbodygood19'
      expect(page).to have_content 'mynewbodygood20'

      within '.answer:last-child' do
        click_on 'Best comment'
      end

      within '.answer:first-child' do
        expect(page).to have_content 'mynewbodygood20'
      end
    end
  end
end
