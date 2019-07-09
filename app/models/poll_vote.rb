class PollVote < ApplicationRecord
  # Associations
  belongs_to :poll_answer
  delegate :poll, to: :poll_answer
  belongs_to :user
end
