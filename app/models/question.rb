class Question < ActiveRecord::Base
  validates :body, presence: true, length: { minimum: 2 }
  validates :title, presence: true, length: { in: 10..200 }

  has_many :answers
end
