class V1::MoviesController < V1::BaseController
  before_action :check_params

  def index
    movies = Movie.live_cached
    movies = movies.search(params[:q]) if params[:q]
    movies = paginate movies

    render json: MovieItemSerializer.new(movies, meta: meta_attributes(movies), params: { current_user: @current_user }).serialized_json
  end

  def search
    param! :q, String

    movies = paginate Movie.search(params[:q])

    render json: MovieItemSerializer.new(movies, meta: meta_attributes(movies), params: { current_user: @current_user }).serialized_json
  end

  def upcoming
    movies = Movie.upcoming_cached
    movies = movies.search(params[:q]) if params[:q]
    movies = paginate movies

    render json: MovieItemSerializer.new(movies, meta: meta_attributes(movies), params: { current_user: @current_user }).serialized_json
  end

  def premiere
    movies = Movie.premiere_cached
    movies = movies.search(params[:q]) if params[:q]
    movies = paginate movies

    render json: MovieItemSerializer.new(movies, meta: meta_attributes(movies), params: { current_user: @current_user }).serialized_json
  end

  def reprojection
    movies = Movie.reprojection_cached
    movies = movies.search(params[:q]) if params[:q]
    movies = paginate movies

    render json: MovieItemSerializer.new(movies, meta: meta_attributes(movies), params: { current_user: @current_user }).serialized_json
  end

  def show
    param! :date, String, blank: true

    movie = Movie.find(params[:id])
    date = selected_date || movie.first_live_showtime&.start_date

    cinemas = movie.cinemas.by_country(selected_country)

    if @current_user
      cinemas = cinemas.by_states(@current_user.states) if @current_user.states.any?
      cinemas = cinemas.by_cities(@current_user.cities) if @current_user.cities.any?
    end

    cinemas = if params[:q].present?
      cinemas.search(params[:q]).by_showtimes_date(date: date)
    else
      cinemas.by_showtimes_date(date: date)
    end

    cinemas = find_closest_cinemas(cinemas)
    favorite_cinemas = @current_user.favorited_cinemas.where(id: cinemas.map(&:id)) if @current_user

    cinemas = paginate cinemas

    cinema_ids = cinemas.map(&:id) + (favorite_cinemas&.pluck(:id) || [])

    params_to_send = {
      movie_id: movie.id,
      cinema_ids: cinema_ids,
      date: date,
      current_user: @current_user,
      latitude: latitude,
      longitude: longitude
    }

    render json: MovieSerializer.new(movie, meta: meta_attributes(cinemas), params: params_to_send, include: [:directors, :casts, :trailers, :genres, :cinemas]).serialized_json
  end

  private
  def check_params
    param! :page, String
    param! :q, String
  end

  def selected_date
    params[:date] if params[:date].present?
  end

  def selected_query
    params[:q] if params[:q].present?
  end

  def find_closest_cinemas(cinemas)
    cinema_ids = cinemas.map(&:id)

    if latitude && longitude
      Cinema.where(id: cinema_ids).near([latitude, longitude], Cinema::RANGE_LIMIT)
    else
      Cinema.where(id: cinema_ids).order_by_name
    end
  end
end
