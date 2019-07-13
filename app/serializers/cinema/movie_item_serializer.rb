class Cinema::MovieItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title, :poster_url, :running_time, :thumbnail_url, :release_date

  attribute :watchlisted do |object, params|
    object.watchlisted?(params[:current_user]) if params[:current_user]
  end

  attribute :watched do |object, params|
    object.watched?(params[:current_user]) if params[:current_user]
  end

  attribute :casts do |object|
    CastSerializer.new(object.casts.first(5)).serializable_hash
  end

  attribute :directors do |object|
    DirectorSerializer.new(object.directors).serializable_hash
  end

  attribute :showtimes do |object, params|
    ShowtimeItemSerializer.new(object.showtimes.by_cinema_and_date(cinema_id: params[:cinema_id], date: params[:date])).serializable_hash
  end
end
