class MovieSerializer
  include FastJsonapi::ObjectSerializer
  attributes :original_title, :title, :poster_url, :thumbnail_url, :backdrop_url, :backdrop_min_url, :synopsis, :running_time, :release_date

  attribute :dates, &:showtime_dates

  attribute :date do |object, params|
    params[:date]
  end

  attribute :watchlisted do |object, params|
    object.watchlisted?(params[:current_user]) if params[:current_user]
  end

  attribute :watched do |object, params|
    object.watched?(params[:current_user]) if params[:current_user]
  end

  has_many :directors
  has_many :trailers
  has_many :genres

  has_many :casts do |object|
    object.casts.first(5)
  end

  has_many :cinemas, serializer: Movie::CinemaItemSerializer do |object, params|
    FindClosestCinemasService.new(params).perform
  end
end
