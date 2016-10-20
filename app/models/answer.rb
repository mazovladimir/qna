class Answer < ActiveRecord::Base
  belongs_to :question#, optional: true

  validates :body, presence: true, length: { minimum: 10 }
end
