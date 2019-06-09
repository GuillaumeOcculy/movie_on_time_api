class WatchedMovie < ApplicationRecord
  # Associations
  belongs_to :user
  belongs_to :movie

  # Validations
  validates_presence_of :watched_date

  # Callbacks
  before_validation :save_watched_date, on: :create

  def save_watched_date
    self.watched_date ||= Date.today
  end
end
