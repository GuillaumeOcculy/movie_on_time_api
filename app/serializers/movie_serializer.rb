class MovieSerializer
  include FastJsonapi::ObjectSerializer
  attributes :original_title, :title, :poster_url, :thumbnail_url, :backdrop_url, :backdrop_min_url, :synopsis, :running_time, :release_date

  attribute :dates, &:showtime_dates

  attribute :date do |object, params|
    params[:date]
  end

  has_many :directors
  has_many :casts
  has_many :trailers
  has_many :genres
  has_many :cinemas, serializer: CinemaItemSerializer do |object, params|
    object.cinemas.by_country('FR').by_showtimes_date(date: params[:date])
  end
end
