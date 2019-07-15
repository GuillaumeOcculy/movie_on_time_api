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

    if latitude && longitude
      cinemas.near([latitude, longitude], Cinema::RANGE_LIMIT)
    elsif !from_mobile && from_france && postal_code
      cinemas.near(postal_code, Cinema::RANGE_LIMIT)
    else
      cinemas
    end
  end

  def from_france
    @params[:country] == 'France'
  end

  def postal_code
    @params[:postal_code]
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

  def from_mobile
    @params[:mobile] == true
  end
end
