class V1::FavoriteCinemasController < V1::BaseController
  before_action :authenticate_token!

  def show
    param! :page, String
    param! :query, String

    cinemas = @current_user.favorited_cinemas.search(params[:q]).order_by_name if params[:q]
    cinemas ||= @current_user.favorited_cinemas.order_by_name
  
    cinemas = paginate cinemas
    render json: CinemaItemSerializer.new(cinemas, meta: meta_attributes(cinemas), params: {current_user: @current_user}).serialized_json
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
