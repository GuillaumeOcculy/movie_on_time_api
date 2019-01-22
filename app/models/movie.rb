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
  scope :dont_have_images, -> {includes(:movie_translations).where(movie_translations: { poster_url: nil } )}
  scope :have_tmdb_id, -> { where.not(tmdb_id: nil) }
  scope :dont_have_trailers_in, -> (language) { have_tmdb_id.select{ |x| x.trailers.where(language: language).empty? } }

  scope :order_by_title, -> (language = 'fr') { includes(:movie_translations).where(movie_translations: {language: language}).order('movie_translations.title ASC') }
  scope :recent,    -> (iso_code = 'FR') { includes(:movie_countries).where(movie_countries: {iso_code: iso_code}).order('movie_countries.release_date DESC').order_by_title }
  scope :old,       -> (iso_code = 'FR') { includes(:movie_countries).where(movie_countries: {iso_code: iso_code}).order('movie_countries.release_date ASC').order_by_title }
  
  scope :live, -> (iso_code: 'FR') { includes(:movie_countries).where('movie_countries.iso_code = :iso_code AND movie_countries.release_date <= :date', {iso_code: iso_code, date: Date.today}).references(:movie_countries).recent(iso_code) }
  scope :upcoming, -> (iso_code: 'FR') { includes(:movie_countries, :movie_translations).merge(MovieCountry.upcoming(iso_code: iso_code)).distinct.old(iso_code) }

  # Methods
  def title(language = 'fr')
    movie_translations.find_by(language: language)&.title || original_title
  end

  def synopsis(language)
    movie_translations.find_by(language: language)&.synopsis || movie_translations.where.not(synopsis: nil).first&.synopsis
  end

  def poster_url(language: 'fr')
    movie_translations.find_by(language: language)&.poster_url || movie_translations.where.not(poster_url: nil).first&.poster_url
  end

  def thumbnail_url(language: 'fr')
    movie_translations.find_by(language: language)&.thumbnail_url || movie_translations.where.not(thumbnail_url: nil).first&.thumbnail_url
  end

  def release_date(iso_code: 'FR')
    movie_countries.find_by(iso_code: iso_code)&.release_date
  end
end
