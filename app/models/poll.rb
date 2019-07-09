class Poll < ApplicationRecord
  # Associations
  belongs_to :user, class_name: 'User', foreign_key: 'creator_id'
  has_many :answers, class_name: 'PollAnswer', dependent: :destroy

  # Validations
  validates_presence_of :body
end
