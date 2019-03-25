class V1::MoviesController < V1::BaseController
  def index
    movies = paginate Movie.live.joins(:showtimes)
    render json: MovieItemSerializer.new(movies, meta: meta_attributes(movies)).serialized_json
  end

  def upcoming
    movies = paginate MoviesControllerovie.upcoming
    render json: MovieItemSerializer.new(movies, meta: meta_attributes(movies)).serialized_json
  end

  def premiere
    movies = paginate Movie.premiere
    render json: MovieItemSerializer.new(movies, meta: meta_attributes(movies)).serialized_json
  end

  def reprojection
    movies = paginate Movie.reprojection
    render json: MovieItemSerializer.new(movies, meta: meta_attributes(movies)).serialized_json
  end

  def show
    param! :date, String, blank: true
    param! :query, String

    movie = Movie.find(params[:id])
    date = selected_date || movie.first_live_showtime&.start_date
    render json: MovieSerializer.new(movie, params: {movie_id: movie.id, date: date, query: selected_query}, include: [:directors, :casts, :trailers, :genres, :cinemas]).serialized_json
  end

  private
  def selected_date
    params[:date] if params[:date].present? 
  end

  def selected_query
    params[:query] if params[:query].present? 
  end
end
