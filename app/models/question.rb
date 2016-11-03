class Question < ActiveRecord::Base
  has_many :answers, dependent: :destroy
  belongs_to :user

  validates :body, presence: true, length: { minimum: 2 }
  validates :title, presence: true, length: { in: 10..200 }
end
