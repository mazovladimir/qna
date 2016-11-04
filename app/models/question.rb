class Question < ActiveRecord::Base
  belongs_to :user
  has_many :answers, dependent: :destroy

  validates :body, presence: true, length: { minimum: 2 }
  validates :title, presence: true, length: { in: 10..200 }
end
