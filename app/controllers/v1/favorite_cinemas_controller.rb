class V1::FavoriteCinemasController < V1::BaseController
  before_action :authenticate_token!
  after_action :save_search, if: -> { selected_query }

  def index
    param! :page, String
    param! :q, String

    cinemas = @current_user.favorited_cinemas.search(params[:q]).order_by_name if params[:q]
    cinemas ||= @current_user.favorited_cinemas.order_by_name

    cinemas = paginate cinemas
    render json: CinemaItemSerializer.new(cinemas, meta: meta_attributes(cinemas), params: {current_user: @current_user}).serialized_json
  end

  def create
    param! :cinema_id, Integer

    favorited = @current_user.favorite_cinemas.find_or_create_by(cinema_id: params[:cinema_id])

    return invalid_resource!(errors = ['cinema not favorited']) if favorited.new_record?

    render json: {}, status: :created
  end

  def destroy
    param! :id, Integer

    @current_user.favorite_cinemas.where(cinema_id: params[:id]).delete_all

    render json: {}, status: :no_content
  end
end
