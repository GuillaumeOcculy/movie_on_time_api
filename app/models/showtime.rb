class Showtime < ApplicationRecord
  # Associations
  belongs_to :cinema
  belongs_to :movie

  # Validations
  validates_presence_of :external_id, :start_at, :start_date

  # Scopes
  scope :ordered_by_date,                 -> { order(start_at: :asc) }
  scope :upcoming,                        -> { where("start_at > ?", Time.now).ordered_by_date }
  scope :by_movie_and_date,               -> (movie_id: movie_id, date: Date.today) { where(movie_id: movie_id, start_date: date).ordered_by_date }

  # Methods
  def start_time
    start_at.strftime("%H:%M")
  end

  def end_time
    end_at&.strftime("%H:%M")
  end

  def version
    language == 'fr' ? 'VF' : 'VO'
  end
end
