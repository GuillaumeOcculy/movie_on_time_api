class Showtime < ApplicationRecord
  # Associations
  belongs_to :cinema
  belongs_to :movie

  # Validations
  validates_presence_of :external_id, :start_at, :start_date

  # Scopes
  scope :ordered_by_date,                 -> { order(start_at: :asc) }
  scope :upcoming,                        -> { where("start_at > ?", Time.now).ordered_by_date }
end
