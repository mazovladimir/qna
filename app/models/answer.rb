class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :user

  validates :body, presence: true, length: { minimum: 10 }

  def best_answer
    ActiveRecord::Base.transaction do
      question.answers.update_all(best: false)
      self.update!(best: true)
    end
  end
end
