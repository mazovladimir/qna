FactoryGirl.define do
  factory :question do
    title "More than 10 symbols"
    body "More than 10 symbols"
  end

  factory :invalid_question, class: "Question" do
    title nil
    body nil
  end

  factory :myquestions, class: "Question" do
    sequence(:title, 5) { |n| "mynewtitle#{n}" }
    sequence(:body, 5) { |n| "mynewbodygood#{n}" }
  end
end
