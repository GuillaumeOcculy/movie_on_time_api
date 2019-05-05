class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :trackable

  has_many :watchlist_movies, dependent: :destroy
  has_many :watchlisted_movies, through: :watchlist_movies, source: :movie

  has_many :favorite_cinemas, dependent: :destroy
  has_many :favorited_cinemas, through: :favorite_cinemas, source: :cinema

  def token
    JsonWebToken.encode(sub: id)
  end
end
