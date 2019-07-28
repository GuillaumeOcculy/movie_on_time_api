class PollVote < ApplicationRecord
  # Associations
  belongs_to :poll_answer
  delegate :poll, to: :poll_answer
  belongs_to :user

  # Callbacks
  after_create_commit :send_thanks_for_your_vote

  # Methods
  def send_thanks_for_your_vote
    PollVoteMailer.thanks_for_your_vote(user).deliver_later
  end
end
