class CreateRatings < ActiveRecord::Migration[5.2]
  def change
    create_table :ratings do |t|
      t.belongs_to :movie, foreign_key: true
      t.string :name
      t.decimal :value
      t.integer :vote_count

      t.timestamps
    end
  end
end
