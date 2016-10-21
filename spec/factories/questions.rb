FactoryGirl.define do
  factory :question do
    title "More than 10 symbols"
    body "More than 10 symbols"
  end

  factory :invalid_question, class: "Question" do
    title nil
    body nil
  end
end
