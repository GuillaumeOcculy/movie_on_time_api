class CreatePollAnswers < ActiveRecord::Migration[5.2]
  def change
    create_table :poll_answers do |t|
      t.belongs_to :poll
      t.text :body, null: false
      t.integer :vote_count

      t.timestamps
    end
  end
end
