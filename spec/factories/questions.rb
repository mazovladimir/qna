FactoryGirl.define do
  factory :question do
    title "More than 10 symbols"
    body "More than 10 symbols"
  end

  factory :invalid_question, class: "Question" do
    title nil
    body nil
  end

  factory :update_question, class: "Question" do
    title 'I update question'
    body 'I update question'
  end

  factory :myquestions, class: "Question" do
    sequence(:title, 1) { |n| "mynewtitle#{n}" }
    sequence(:body, 1) { |n| "mynewbodygood#{n}" }
  end
end
