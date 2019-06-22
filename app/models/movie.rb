class Movie < ApplicationRecord
  include Cachable

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

  has_many :watchlist_movies, dependent: :destroy
  has_many :watchlisted_by_users, through: :watchlist_movies, source: :user

  has_many :watched_movies, dependent: :destroy
  has_many :watched_by_users, through: :watched_movies, source: :user

  # Validations
  validates :external_id, presence: true, uniqueness: true

  # Scopes
  scope :draft, -> { where(original_title: nil) }
  scope :ready, -> { where.not(original_title: nil) }
  scope :dont_have_images, -> {includes(:movie_translations).where(movie_translations: { poster_url: nil } )}
  scope :have_images, -> { where.not(id: dont_have_images) }
  scope :have_tmdb_id, -> { where.not(tmdb_id: nil) }
  scope :dont_have_trailers_in, -> (language) { have_tmdb_id.select{ |x| x.trailers.where(language: language).empty? } }

  scope :order_by_title, -> (language = 'fr') { includes(:movie_translations).where(movie_translations: {language: language}).order('movie_translations.title ASC') }
  scope :recent,    -> (iso_code = 'FR') { includes(:movie_countries).where(movie_countries: {iso_code: iso_code}).order('movie_countries.release_date DESC').order_by_title }
  scope :old,       -> (iso_code = 'FR') { includes(:movie_countries).where(movie_countries: {iso_code: iso_code}).order('movie_countries.release_date ASC').order_by_title }
  scope :old_premiere, -> { includes(:showtimes).order('showtimes.start_at') }

  scope :search, -> (query) { includes(:movie_translations).where('movies.original_title ILIKE :q OR movie_translations.title ILIKE :q', q: "%#{query}%").recent }

  scope :by_showtimes_date, -> (date: Date.today) { where(showtimes: {start_date: date}).recent }
  
  scope :live, -> (iso_code: 'FR') { includes(:movie_countries).where('movie_countries.iso_code = :iso_code AND movie_countries.release_date <= :date', {iso_code: iso_code, date: Date.today}).references(:movie_countries).recent(iso_code) }
  scope :upcoming, -> (iso_code: 'FR') { includes(:movie_countries).where('movie_countries.iso_code = :iso_code AND movie_countries.release_date > :date', {iso_code: iso_code, date: Date.today}).references(:movie_countries).old(iso_code) }
  scope :reprojection, -> (iso_code: 'FR') do
    movie_ids = joins(:movie_countries, :cinemas).merge(MovieCountry.reprojection(iso_code: iso_code)).merge(Cinema.by_country(iso_code)).distinct
    Movie.includes(:movie_translations).where(id: movie_ids).old_premiere
  end

  scope :premiere, -> (iso_code: 'FR') do
    movies = joins(:movie_countries, :cinemas).merge(MovieCountry.upcoming(iso_code: iso_code)).merge(Cinema.by_country(iso_code)).distinct
    movie_ids = movies.select do |movie|
      showtime = movie.first_live_showtime(iso_code)
      movie_country = movie.movie_countries.find_by(iso_code: iso_code)
      showtime.start_date < movie_country.release_date
    end.pluck(:id)

    Movie.where(id: movie_ids).old_premiere
  end

  # Methods
  def title(language = 'fr')
    movie_translations.find_by(language: language)&.title || original_title
  end

  def synopsis(language: 'fr')
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

  def showtimes_by_country(iso_code= 'FR')
    showtimes.joins(:cinema).merge(Cinema.by_country(iso_code))
  end

  def first_live_showtime(iso_code= 'FR')
    showtimes_by_country(iso_code).order(:start_date).first
  end

  def showtime_dates
    showtimes.ordered_by_date.pluck(:start_date).uniq.first(7)
  end

  def watchlisted?(user)
    watchlisted_by_users.exists?(user.id)
  end

  def watched?(user)
    watched_by_users.exists?(user.id)
  end
end
