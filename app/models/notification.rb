class Notification < ApplicationRecord
  # Enums
  enum status: [ :movie_released ]

  # Associations
  belongs_to :recipient, class_name: 'User'
  belongs_to :actorable, polymorphic: true
  belongs_to :notifiable, polymorphic: true

  # Validations
  validates_presence_of :action

   # Scopes
  scope :unread,  -> { where(read_at: nil) }
  scope :read,    -> { where.not(read_at: nil).order(read_at: :desc) }
end
