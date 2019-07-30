# Search and save movies when not found in the database
# SaveNewMoviesService.new('Avengers').perform

class SaveNewMoviesService
  def initialize(query)
    @query = query
  end

  def perform
    search_movies
    create_movies
    save_movie_details
  end

  private

  def search_movies
    @movie_ids = Api::InternationalShowtimes::Base.new.search_movies(@query)
  end

  def movie_ids
    @movie_ids.pluck(:id)
  end

  def create_movies
    movie_ids.each do |movie_id|
      Movie.find_or_create_by!(external_id: movie_id)
    end
  end

  def save_movie_details
    Api::InternationalShowtimes::Import.new.save_movie_details_from_service(movie_ids)
  end
end
