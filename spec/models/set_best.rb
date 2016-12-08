require 'rails_helper'

RSpec.describe Answer, type: :model do
  let(:user) { create(:user) }
  let(:question) { create(:question, user: user) }
  let!(:myanswers) { create_list(:myanswers, 5, question: question, user: user) }

  it 'should check best answer' do
    answer = myanswers.first
    answer.update(best: true)
    expect(answer.best).to eq true

    lanswer = myanswers.last
    lanswer.best_answer
    expect(answer.best).to eq false
    expect(lanswer.best).to eq true
  end
end
