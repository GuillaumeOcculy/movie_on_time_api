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
    return cinemas.order_by_name if (country != 'France') || postal_code.empty?

    cinemas = cinemas.near(postal_code)
    cinemas
  end

  def country
    @params[:country]
  end

  def postal_code
    @params[:postal_code]
  end

  def cinema_ids
    @params[:cinema_ids]
  end
end
