class CreateMovieTranslations < ActiveRecord::Migration[5.2]
  def change
    create_table :movie_translations do |t|
      t.belongs_to :movie, foreign_key: true
      t.string :language
      t.string :title
      t.string :synopsis
      t.string :poster_url
      t.string :thumbnail_url

      t.timestamps
    end
  end
end
