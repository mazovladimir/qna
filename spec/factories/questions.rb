FactoryGirl.define do
  factory :question do
    title "More than 10 symbols"
    body "More than 10 symbols"
  end

  factory :invalid_question, class: "Question" do
    title nil
    body nil
  end

  sequence :question_list do |n|
    "user#{n}@test.com"
  end

  factory :question_list do
    email
    password '12345678'
    password_confirmation '12345678'
  end
end
