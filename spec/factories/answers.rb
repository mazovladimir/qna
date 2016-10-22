FactoryGirl.define do
  factory :answer do
    body "More than 10 symbols"
    question Question.new
  end

  factory :invalid_answer, class: "Answer" do
    body nil
  end
end
