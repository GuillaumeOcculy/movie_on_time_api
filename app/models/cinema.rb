class Cinema < ApplicationRecord
  # Associations
  belongs_to :chain, required: false
  belongs_to :country

  has_many :showtimes,      -> { where('start_date >= ?', Date.today) }, dependent: :destroy
  has_many :movies,         -> { distinct }, through: :showtimes

  # Validations
  validates_presence_of :external_id, :name

  # Scopes
  scope :order_by_name,     -> { order(:name) }
  scope :by_country,        -> (iso_code) { where(country_code: iso_code) }
  scope :in_paris,          -> { where(city: 'Paris').order_by_name }
  scope :by_showtimes_date, -> (date: Date.today) { where(showtimes: {start_date: date}).order_by_name }

  # Methods
  def first_live_showtime
    showtimes.order(:start_date).first
  end

  def showtime_dates
    showtimes.ordered_by_date.pluck(:start_date).uniq.first(7)
  end
end
