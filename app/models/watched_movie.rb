class WatchedMovie < ApplicationRecord
  # Associations
  belongs_to :user
  belongs_to :movie

  # Validations
  validates_presence_of :watched_date

  # Callbacks
  before_create { self.watched_date ||= Date.today }
end
