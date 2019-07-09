class PollAnswer < ApplicationRecord
  # Associations
  belongs_to :poll
  has_many :poll_votes, dependent: :destroy

  # Callbacks
  before_create { self.vote_count = 1 }
end
