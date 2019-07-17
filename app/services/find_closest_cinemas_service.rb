class FindClosestCinemasService
  def initialize(params)
    @params = params
  end

  def perform
    fetch_cinemas
  end

  private

  def fetch_cinemas
    cinemas = Cinema.where(id: cinema_ids)
    return unless latitude && longitude

    cinemas.near([latitude, longitude], Cinema::RANGE_LIMIT)
  end

  def latitude
    @params[:latitude]
  end

  def longitude
    @params[:longitude]
  end

  def cinema_ids
    @params[:cinema_ids]
  end
end
