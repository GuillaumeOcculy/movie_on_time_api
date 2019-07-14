class CinemaSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name, :street, :post_code, :city, :ugc_unlimited?

  attribute :dates, &:showtime_dates

  attribute :date do |object, params|
    params[:date]
  end

  attribute :favorited do |object, params|
    object.favorited?(params[:current_user]) if params[:current_user]
  end

  has_many :movies, serializer: Cinema::MovieItemSerializer do |object, params|
    object.movies.by_showtimes_date(date: params[:date])
  end
end
