class CreateWatchedMovies < ActiveRecord::Migration[5.2]
  def change
    create_table :watched_movies do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :movie, foreign_key: true
      t.date :watched_date

      t.timestamps
    end
  end
end
