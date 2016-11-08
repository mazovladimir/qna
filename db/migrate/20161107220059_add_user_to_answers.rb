class AddUserToAnswers < ActiveRecord::Migration[5.0]
  def change
    add_column :answers, :user, :integer
  end
end
