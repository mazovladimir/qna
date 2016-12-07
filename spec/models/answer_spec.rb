require 'rails_helper'

RSpec.describe Answer, type: :model do
  it { should belong_to(:question) }
  it { should belong_to(:user) }
  it { should validate_presence_of :body }
  it { should validate_length_of(:body).is_at_least(10) }

  let(:user) { create(:user) }
  let(:question) { create(:question, user: user) }
  let(:myanswers) { create_list(:myanswers, 5, question: question, user: user) }

  it 'should check best answer' do
    answer = myanswers.first
    answer.best_answer
    myanswers.each do |myanswer|
      myanswer.best.should == false if !answer
    end

    lanswer = myanswers.last
    lanswer.best_answer
    myanswers.each do |myanswer|
      myanswer.best.should == false if !lanswer
    end
  end
end
