class V1::CinemasController < ApplicationController
  def index
    cinemas = Cinema.in_paris
    render json: CinemaItemSerializer.new(cinemas).serialized_json
  end

  def show
    param! :date, Date, blank: true
    
    cinema = Cinema.find(params[:id])
    date = params[:date] || cinema.first_live_showtime&.start_date
    render json: CinemaSerializer.new(cinema, params: {cinema_id: cinema.id, date: date}, include: [:movies]).serialized_json
  end
end
