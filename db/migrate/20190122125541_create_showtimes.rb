class CreateShowtimes < ActiveRecord::Migration[5.2]
  def change
    create_table :showtimes do |t|
      t.belongs_to :cinema, foreign_key: true
      t.belongs_to :movie, foreign_key: true
      t.string :external_id
      t.date :start_date
      t.datetime :start_at
      t.datetime :end_at
      t.string :language
      t.string :subtitle_language
      t.string :auditorium
      t.string :dimension, default: '2D'
      t.string :country_code
      t.string :booking_type
      t.string :booking_link

      t.timestamps
    end
    add_index  :showtimes, [:movie_id, :country_code]
    add_index  :showtimes, [:cinema_id, :country_code]
    add_index  :showtimes, [:movie_id, :start_at]
  end
end
