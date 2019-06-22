class V1::WatchlistsController < V1::BaseController
  before_action :authenticate_token!

  def show
    param! :page, String
    param! :q, String

    movies = @current_user.watchlisted_movies.search(params[:q]) if params[:q]
    movies ||= @current_user.watchlisted_movies.old
  
    movies = paginate movies
    render json: MovieItemSerializer.new(movies, meta: meta_attributes(movies), params: { current_user: @current_user } ).serialized_json
  end

  def create
    param! :id, Integer

    @current_user.watchlist_movies.find_or_create_by(movie_id: params[:id])

    render json: {}, status: :created
  end

  def destroy
    param! :id, Integer

    @current_user.watchlist_movies.where(movie_id: params[:id]).delete_all

    render json: {}, status: :no_content
  end
end
