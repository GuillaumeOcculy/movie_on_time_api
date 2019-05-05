class WatchedMovie < ApplicationRecord
  # Associations
  belongs_to :user
  belongs_to :movie

  # Callbacks
  before_create { self.watched_date ||= Date.today }
end
