class MovieItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title, :poster_url, :thumbnail_url, :release_date, :first_live_showtime_date

  attribute :watchlisted do |object, params|
    object.watchlisted?(params[:current_user])
  end

  attribute :watched do |object, params|
    object.watched?(params[:current_user])
  end
end
