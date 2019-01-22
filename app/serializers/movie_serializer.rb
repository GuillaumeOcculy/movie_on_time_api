class MovieSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :original_title, :title, :poster_url, :thumbnail_url, :backdrop_url, :backdrop_min_url, :synopsis, :running_time, :release_date

  attribute :dates, &:showtime_dates

  attribute :date do |object|
    object.first_live_showtime&.start_date
  end

  has_many :directors
  has_many :casts
  has_many :trailers
  has_many :genres
end
