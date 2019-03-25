class V1::ShowtimesController < V1::BaseController
  def show
    showtime = Showtime.find(params[:id])
    render json: ShowtimeSerializer.new(showtime).serialized_json
  end
end
