class V1::ShowtimesController < ApplicationController
  def show
    showtime = Showtime.find(params[:id])
    render json: ShowtimeSerializer.new(showtime).serialized_json
  end
end
