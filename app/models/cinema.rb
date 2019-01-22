class Cinema < ApplicationRecord
  # Associations
  belongs_to :chain, required: false
  belongs_to :country

  has_many :showtimes,      -> { where('start_date >= ?', Date.today) }, dependent: :destroy
  has_many :movies,         -> { distinct }, through: :showtimes

  # Validations
  validates_presence_of :external_id, :name
end
