class Movie < ApplicationRecord
  # Associations
  has_many :showtimes,    -> { where 'start_date >= ?', Date.today  }, dependent: :destroy
  has_many :cinemas,      -> { distinct }, through: :showtimes

  has_many :movie_countries, dependent: :destroy
  has_many :countries, through: :movie_countries
  
  has_many :movie_genres, dependent: :destroy
  has_many :genres, through: :movie_genres
  
  has_many :casts, dependent: :destroy
  has_many :directors, dependent: :destroy
  has_many :ratings, dependent: :destroy
  has_many :trailers, dependent: :destroy

  has_many :movie_translations, dependent: :destroy

  # Validations
  validates :external_id, presence: true, uniqueness: true

  # Scopes
  scope :draft, -> { where(original_title: nil) }
  scope :ready, -> { where.not(original_title: nil) }
end
