class MovieGenre < ApplicationRecord
  # Associations
  belongs_to :movie
  belongs_to :genre
end
