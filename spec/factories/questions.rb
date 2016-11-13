FactoryGirl.define do
  factory :question do
    title "More than 10 symbols"
    body "More than 10 symbols"
  end

  factory :invalid_question, class: "Question" do
    title nil
    body nil
  end

  sequence :title do |n|
    "mynewtitle#{n}"
  end

  sequence :body do |n|
    "mynewbodygood#{n}"
  end

  factory :myquestions, class: "Question" do
    title
    body 
  end
end
