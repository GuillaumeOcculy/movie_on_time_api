class MovieCountry < ApplicationRecord
  # Associations
  belongs_to :movie
  belongs_to :country

  # Scopes
  scope :upcoming, -> (iso_code: 'FR') { where("release_date > :date AND iso_code = :iso_code", {date: Date.today, iso_code: iso_code}) }
  scope :reprojection, -> (iso_code: 'FR') { where("release_date <= :date AND movie_countries.iso_code = :iso_code", {date: Date.today - 6.months, iso_code: iso_code}) }
end
