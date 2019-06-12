class V1::MoviesController < V1::BaseController
  before_action :check_params

  def index
    movies = Movie.live_cached
    movies = movies.search(params[:query]) if params[:query]
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
    movies = movies.search(params[:query]) if params[:query]
    movies = paginate movies

    render json: MovieItemSerializer.new(movies, meta: meta_attributes(movies), params: { current_user: @current_user }).serialized_json
  end

  def premiere
    movies = Movie.premiere_cached
    movies = movies.search(params[:query]) if params[:query]
    movies = paginate movies

    render json: MovieItemSerializer.new(movies, meta: meta_attributes(movies), params: { current_user: @current_user }).serialized_json
  end

  def reprojection
    movies = Movie.reprojection_cached
    movies = movies.search(params[:query]) if params[:query]
    movies = paginate movies

    render json: MovieItemSerializer.new(movies, meta: meta_attributes(movies), params: { current_user: @current_user }).serialized_json
  end

  def show
    param! :date, String, blank: true

    movie = Movie.find(params[:id])
    date = selected_date || movie.first_live_showtime&.start_date

    cinemas = if params[:query]
      movie.cinemas.in_france.search(params[:query]).by_showtimes_date(date: date)
    else
      movie.cinemas.in_france.by_showtimes_date(date: date)
    end

    if @current_user
      favorite_cinemas = @current_user.favorited_cinemas.where(id: cinemas.map(&:id))
      cinemas = cinemas.where.not(id: favorite_cinemas)
    end

    cinemas = paginate cinemas

    cinema_ids = cinemas.map(&:id)
    favorite_cinema_ids = favorite_cinemas&.map(&:id) || []

    render json: MovieSerializer.new(movie, meta: meta_attributes(cinemas), params: { movie_id: movie.id, cinema_ids: cinema_ids, date: date, current_user: @current_user, favorite_cinema_ids: favorite_cinema_ids }, include: [:directors, :casts, :trailers, :genres, :cinemas, :favorited_cinemas]).serialized_json
  end

  private
  def check_params
    param! :page, String
    param! :query, String
  end

  def selected_date
    params[:date] if params[:date].present?
  end

  def selected_query
    params[:query] if params[:query].present?
  end
end
