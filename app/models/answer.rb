class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :user

  validates :body, presence: true, length: { minimum: 10 }

  def best_answer
    self.update(best: 1)
    Answer.all.each do |myanswer|
      myanswer.update(best: 0) if myanswer.id != self.id
    end
  end
end
