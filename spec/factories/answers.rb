FactoryGirl.define do
  factory :answer do
    body "lot More than 10 symbols"
    question Question.new
  end

  factory :invalid_answer, class: "Answer" do
    body nil
  end

  factory :myanswers, class: "Answer" do
    sequence(:body, 1) { |n| "mynewbodygood#{n}" }
  end
end
