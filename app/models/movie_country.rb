class MovieCountry < ApplicationRecord
  # Associations
  belongs_to :movie
  belongs_to :country

  # Scopes
  scope :upcoming, -> (iso_code: 'FR') { where("release_date > :date AND iso_code = :iso_code", {date: Date.today, iso_code: iso_code}) }
end
