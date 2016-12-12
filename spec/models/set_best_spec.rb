require 'rails_helper'

RSpec.describe Answer, type: :model do
  let!(:user) { create(:user, email: 'vovka@ruzik.net', password: '12345678', password_confirmation: '12345678') }
  let!(:question) { create(:question, user: user) }
  let!(:answer1) { create(:answer, question: question, user: user) }
  let!(:answer2) { create(:answer, question: question, user: user) }

  it 'should check best answer' do
    expect(answer1.best).to eq false
    expect(answer2.best).to eq false

    answer1.best_answer
    expect(answer1.best).to eq true
    expect(answer2.best).to eq false

    answer2.best_answer
    expect(answer1.best).to eq false
    expect(answer2.best).to eq true
  end
end
