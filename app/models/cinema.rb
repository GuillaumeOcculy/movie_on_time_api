class Cinema < ApplicationRecord
  UGC_LIST = YAML.load_file(Rails.root.join('app', 'data', 'cinemas_ugc_unlimited.yml'))['cinemas']

  # Associations
  belongs_to :chain, required: false
  belongs_to :country

  has_many :showtimes,      -> { where('start_date >= ?', Date.today) }, dependent: :destroy
  has_many :movies,         -> { distinct }, through: :showtimes

  has_many :favorite_cinemas, dependent: :destroy
  has_many :favorited_by_users, through: :favorite_cinemas, source: :user

  # Validations
  validates_presence_of :external_id, :name

  # Scopes
  scope :order_by_name,     -> { order(:name) }
  scope :search,            -> (search) { where('name ILIKE :q OR city ILIKE :q', q: "%#{search}%").order_by_name }
  scope :by_country,        -> (iso_code) { where(country_code: iso_code) }
  scope :by_states,         -> (states) { where(state: states) }
  scope :by_cities,         -> (cities) { where(city: cities) }
  scope :in_france,         -> { by_country('FR')}
  scope :in_paris,          -> { where(city: 'Paris').order_by_name }
  scope :by_showtimes_date, -> (date: Date.today) { where(showtimes: {start_date: date}).order_by_name }

  # Methods
  def first_live_showtime
    showtimes.order(:start_date).first
  end

  def showtime_dates
    showtimes.ordered_by_date.pluck(:start_date).uniq.first(7)
  end

  def favorited?(user)
    favorited_by_users.exists?(user.id)
  end

  def ugc_unlimited?
    UGC_LIST.include?(name)
  end
end
