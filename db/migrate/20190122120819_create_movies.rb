class CreateMovies < ActiveRecord::Migration[5.2]
  def change
    create_table :movies do |t|
      t.string :external_id
      t.string :original_title
      t.string :original_language
      t.string :imdb_id
      t.string :tmdb_id
      t.string :rentrak_film_id
      t.integer :running_time
      t.string :status
      t.string :website
      t.string :backdrop_url
      t.string :backdrop_min_url

      t.timestamps
    end
  end
end
