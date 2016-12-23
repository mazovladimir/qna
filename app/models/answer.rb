class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :user

  has_many :attachments, as: :attachable

  accepts_nested_attributes_for :attachments, reject_if: :all_blank

  validates :body, presence: true, length: { minimum: 10 }

  def best_answer
    if self.best != true
      ActiveRecord::Base.transaction do
        question.answers.update_all(best: false)
        self.update!(best: true)
      end
    end
  end
end
