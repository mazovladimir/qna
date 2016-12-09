require 'rails_helper'

RSpec.describe Answer, type: :model do
  let(:user) { create(:user) }
  let(:question) { create(:question, user: user) }
  let!(:myanswers) { create_list(:myanswers, 5, question: question, user: user) }

  it 'should check best answer' do
    answer = myanswers.first
    lanswer = myanswers.last
    expect(answer.best).to eq false

    answer.update(best: true)
    expect(answer.best).to eq true
    expect(lanswer.best).to eq false

    lanswer.best_answer
    expect(answer.best).to eq false
    expect(lanswer.best).to eq true
  end
end
