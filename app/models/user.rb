class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :trackable

  # Associations
  has_many :watchlist_movies, dependent: :destroy
  has_many :watchlisted_movies, through: :watchlist_movies, source: :movie

  has_many :watched_movies, dependent: :destroy
  has_many :movies_watched, through: :watched_movies, source: :movie

  has_many :favorite_cinemas, dependent: :destroy
  has_many :favorited_cinemas, through: :favorite_cinemas, source: :cinema

  has_many :notifications, foreign_key: :recipient_id, dependent: :destroy

  # has_many :polls, foreign_key: :creator_id
  has_many :poll_votes, dependent: :destroy
  has_many :poll_answers, through: :poll_votes
  has_many :polls_answered, through: :poll_answers, source: :poll

  # enum
  enum role: %i(guest member moderator admin)

  # Callbacks
  after_create_commit :send_welcome_mailer

  # Settings
  typed_store :settings do |s|
    s.string  :language, default: 'fr'
    s.string  :country, default: 'FR'
    s.string  :states, array: true, default: [], null: false
    s.string  :cities, array: true, default: [], null: false
  end

  # Methods
  def token
    JsonWebToken.encode(sub: id)
  end

  private
  def send_welcome_mailer
    UserMailer.welcome(self).deliver_later
  end
end
