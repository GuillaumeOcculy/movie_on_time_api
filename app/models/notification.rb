class Notification < ApplicationRecord
  # Enums
  enum status: [ :movie_released ]

  # Associations
  belongs_to :recipient, class_name: 'User'
  belongs_to :actorable, polymorphic: true
  belongs_to :notifiable, polymorphic: true

  # Validations
  validates_presence_of :action

  # Callbacks
  after_create_commit :send_notification_mailer

   # Scopes
  scope :unread,  -> { where(read_at: nil).order(read_at: :desc) }
  scope :read,    -> { where.not(read_at: nil).order(read_at: :desc) }

  private
  def send_notification_mailer
    case action
    when 'movie_released'; then NotificationsMailer.movie_released(recipient, notifiable).deliver_later
    end
  end
end
