class MovieTranslation < ApplicationRecord
  # Associations
  belongs_to :movie

  # Validations
  validates_presence_of :language

  # Scopes
  scope :order_by_title, -> { order('title ASC') }
  scope :by_iso_code_and_date, -> (iso_code = 'FR', date = Date.today) { where('movie_countries.iso_code = :iso_code AND movie_countries.release_date <= :date', {iso_code: iso_code, date: Date.today}) }
end
