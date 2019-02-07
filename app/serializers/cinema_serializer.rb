class CinemaSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name, :street, :post_code, :city

  attribute :dates, &:showtime_dates

  attribute :date do |object, params|
    params[:date]
  end

  has_many :movies, serializer: Cinema::MovieItemSerializer do |object, params|
    object.movies.by_showtimes_date(date: params[:date])
  end
end
