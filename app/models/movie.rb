class Movie < ApplicationRecord
  # Associations
  has_many :showtimes,    -> { where 'start_date >= ?', Date.today  }, dependent: :destroy
  has_many :cinemas,      -> { distinct }, through: :showtimes

  # Validations
  validates :external_id, presence: true, uniqueness: true
end
