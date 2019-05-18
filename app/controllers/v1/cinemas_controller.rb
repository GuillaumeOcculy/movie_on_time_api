class V1::CinemasController < V1::BaseController
  def index
    param! :query, String

    if params[:query]
      cinemas = Cinema.in_france.search(params[:query])
    else
      cinemas = Cinema.in_france.order_by_name
    end

    cinemas = paginate cinemas
    render json: CinemaItemSerializer.new(cinemas, meta: meta_attributes(cinemas), params: {current_user: @current_user}).serialized_json
  end

  def show
    param! :date, Date, blank: true
    
    cinema = Cinema.find(params[:id])
    date = params[:date] || cinema.first_live_showtime&.start_date
    render json: CinemaSerializer.new(cinema, params: {cinema_id: cinema.id, date: date, current_user: @current_user}, include: [:movies]).serialized_json
  end
end
