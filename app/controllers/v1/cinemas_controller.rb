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
    favorite_cinemas = @current_user.favorited_cinemas.where(id: cinemas.map(&:id)) if @current_user

    cinemas = paginate cinemas

    cinema_ids = cinemas.map(&:id)
    favorite_cinema_ids = favorite_cinemas.pluck(:id)

    cinemas = Cinema.where(id: favorite_cinema_ids + cinema_ids)
    cinemas = paginate cinemas

    render json: CinemaItemSerializer.new(cinemas, meta: meta_attributes(cinemas), params: { current_user: @current_user }).serialized_json
  end

  def show
    param! :date, Date, blank: true

    cinema = Cinema.find(params[:id])
    date = params[:date] || cinema.first_live_showtime&.start_date
    render json: CinemaSerializer.new(cinema, params: { cinema_id: cinema.id, date: date, current_user: @current_user }, include: [:movies]).serialized_json
  end

  private

  def get_cinemas
    Cinema.by_country(selected_country).order_by_name
  end

  def find_closest_cinemas(cinemas)
    return cinemas unless latitude && longitude

    cinemas = Cinema.where(id: cinemas.map(&:id)) # Must do that to reset the scope order_by_name
    cinemas.near([latitude, longitude], Cinema::RANGE_LIMIT)
  end
end
