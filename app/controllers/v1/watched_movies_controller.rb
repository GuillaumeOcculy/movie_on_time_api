class V1::WatchedMoviesController < V1::BaseController
  before_action :authenticate_token!

  def show
    param! :page, String
    param! :query, String

    movies = @current_user.movies_watched.search(params[:q]) if params[:q]
    movies ||= @current_user.movies_watched.recent
  
    movies = paginate movies
    render json: MovieItemSerializer.new(movies, meta: meta_attributes(movies), params: { current_user: @current_user }).serialized_json
  end

  def create
    param! :movie_id, Integer

    @current_user.watched_movies.find_or_create_by(movie_id: params[:movie_id])
    @current_user.watchlist_movies.where(movie_id: params[:movie_id]).delete_all

    render json: {}, status: :created
  end

  def destroy
    param! :movie_id, Integer

    @current_user.watched_movies.where(movie_id: params[:movie_id]).delete_all

    render json: {}, status: :no_content
  end
end
