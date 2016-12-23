class Question < ActiveRecord::Base
  belongs_to :user
  has_many :answers, dependent: :destroy
  has_many :attachments, as: :attachable

  validates :body, presence: true, length: { minimum: 2 }
  validates :title, presence: true, length: { in: 10..200 }

  accepts_nested_attributes_for :attachments, reject_if: :all_blank
end
