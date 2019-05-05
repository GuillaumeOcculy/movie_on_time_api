class FavoriteCinema < ApplicationRecord
  # Associations
  belongs_to :user
  belongs_to :cinema
end
