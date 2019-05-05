class V1::FavoriteCinemasController < V1::BaseController
  before_action :authenticate_token!

  def show
    param! :page, String
    param! :query, String

    movies = @current_user.favorited_cinemas.search(params[:q]) if params[:q]
    movies ||= @current_user.favorited_cinemas
  
    movies = paginate movies
    render json: CinemaItemSerializer.new(movies, meta: meta_attributes(movies)).serialized_json
  end

  def create
    param! :cinema_id, Integer

    @current_user.favorite_cinemas.find_or_create_by(cinema_id: params[:cinema_id])

    render json: {}, status: :created
  end

  def destroy
    param! :cinema_id, Integer

    @current_user.favorite_cinemas.where(cinema_id: params[:cinema_id]).delete_all

    render json: {}, status: :no_content
  end
end
