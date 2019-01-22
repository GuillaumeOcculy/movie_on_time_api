class MovieCountry < ApplicationRecord
  # Associations
  belongs_to :movie
  belongs_to :country
end
