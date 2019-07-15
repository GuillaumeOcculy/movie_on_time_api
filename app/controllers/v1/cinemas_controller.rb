class V1::CinemasController < V1::BaseController
  def index
    param! :q, String

    cinemas = get_cinemas

    if @current_user
      cinemas = cinemas.by_states(@current_user.states) if @current_user.states.any?
      cinemas = cinemas.by_cities(@current_user.cities) if @current_user.cities.any?
    end

    cinemas = cinemas.search(params[:q]) if params[:q]
    cinemas = find_closest_cinemas(cinemas)

    cinemas = paginate cinemas

    render json: CinemaItemSerializer.new(cinemas, meta: meta_attributes(cinemas), params: {current_user: @current_user}).serialized_json
  end

  def show
    param! :date, Date, blank: true

    cinema = Cinema.find(params[:id])
    date = params[:date] || cinema.first_live_showtime&.start_date
    render json: CinemaSerializer.new(cinema, params: {cinema_id: cinema.id, date: date, current_user: @current_user}, include: [:movies]).serialized_json
  end

  private

  def get_cinemas
    Cinema.by_country(selected_country)
  end

  def from_mobile
    params[:mobile] == 'true'
  end

  def from_france
    params[:country] == 'France'
  end

  def find_closest_cinemas(cinemas)
    return cinemas if from_mobile || !from_france || params[:postal_code].nil?

    cinemas.near(params[:postal_code], Cinema::RANGE_LIMIT)
  end
end
