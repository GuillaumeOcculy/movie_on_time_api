class Showtime < ApplicationRecord
  # Associations
  belongs_to :cinema
  belongs_to :movie

  # Validations
  validates_presence_of :external_id, :start_at, :start_date
end
