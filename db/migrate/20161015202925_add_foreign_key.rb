class AddForeignKey < ActiveRecord::Migration[5.0]
  change_table :answers do |t|
    t.remove :question_id
  end
end
