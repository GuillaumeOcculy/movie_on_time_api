class CreateMovieCountries < ActiveRecord::Migration[5.2]
  def change
    create_table :movie_countries do |t|
      t.belongs_to :movie, foreign_key: true
      t.belongs_to :country, foreign_key: true
      t.date :release_date
      t.string :iso_code

      t.timestamps
    end
    add_index :movie_countries, :release_date
    add_index :movie_countries, [:iso_code, :release_date]
    add_index :movie_countries, [:movie_id, :iso_code]
  end
end
