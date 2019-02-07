class CinemaItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :street, :post_code, :city

  attribute :showtimes do |object, params|
    ShowtimeItemSerializer.new(object.showtimes.by_movie_and_date(movie_id: params[:movie_id], date: params[:date])).serializable_hash
  end
end
