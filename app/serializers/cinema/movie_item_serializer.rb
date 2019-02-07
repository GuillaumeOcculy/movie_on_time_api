class Cinema::MovieItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title, :poster_url, :running_time, :thumbnail_url, :release_date

  attribute :casts do |object|
    CastSerializer.new(object.casts).serializable_hash
  end

  attribute :directors do |object|
    DirectorSerializer.new(object.directors).serializable_hash
  end

  attribute :showtimes do |object, params|
    ShowtimeItemSerializer.new(object.showtimes.by_cinema_and_date(cinema_id: params[:cinema_id], date: params[:date])).serializable_hash
  end
end
