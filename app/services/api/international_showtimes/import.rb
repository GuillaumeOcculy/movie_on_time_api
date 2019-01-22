# Api::InternationalShowtimes::Import.new.perform
module Api::InternationalShowtimes
  class Import < Base
    def perform
      save_genres
      save_cities
      save_chains
      save_cinemas
      save_upcoming_movies
      purge_old_showtimes
      save_showtimes
    end

    # Api::InternationalShowtimes::Import.new.save_genres
    def save_genres
      genres.each do |genre|
        Genre.find_or_create_by(external_id: genre[:id], name: genre[:name])
      end
    end

    # Api::InternationalShowtimes::Import.new.save_cities
    def save_cities
      cities.each do |city|
        @country.cities.find_or_create_by(external_id: city[:id], name: city[:name]) do |new_city|
          new_city.latitude = city[:lat]
          new_city.longitude = city[:lon]
          new_city.country_code = city[:country]
        end
      end
    end

    # Api::InternationalShowtimes::Import.new.save_chains
    def save_chains
      chains.each do |chain|
        new_chain = Chain.find_or_create_by(external_id: chain[:id], name: chain[:name])
        new_chain.chain_countries.find_or_create_by(country: @country)
      end
    end

    # Api::InternationalShowtimes::Import.new.save_cinemas
    def save_cinemas
      cinemas.each do |cinema|
        chain = Chain.find_by(external_id: cinema[:chain_id])
        if chain 
          new_cinema = chain.cinemas.find_or_initialize_by(external_id: cinema[:id], name: cinema[:name], country: @country)
        else
          new_cinema = Cinema.find_or_initialize_by(external_id: cinema[:id], name: cinema[:name], country: @country)
        end

        new_cinema.phone = cinema[:telephone]
        new_cinema.website = cinema[:website]
        new_cinema.street = cinema[:location][:address][:street]
        new_cinema.house = cinema[:location][:address][:house]
        new_cinema.post_code = cinema[:location][:address][:zipcode]
        new_cinema.city = cinema[:location][:address][:city]
        new_cinema.state = cinema[:location][:address][:state]
        new_cinema.state_abbr = cinema[:location][:address][:state_abbr]
        new_cinema.country_code = cinema[:location][:address][:country_code]
        new_cinema.latitude = cinema[:location][:lat]
        new_cinema.longitude = cinema[:location][:lon]
        new_cinema.booking_type = cinema[:location][:booking_type]
        new_cinema.image_url = cinema[:location][:image_url]
        new_cinema.save
      end
    end

    # Api::InternationalShowtimes::Import.new.save_upcoming_movies
    def save_upcoming_movies(country: 'FR')
      upcoming_movies(country: country).each do |movie|
        new_movie = Movie.find_or_create_by!(external_id: movie[:id])
      end
    end

    # Api::InternationalShowtimes::Import.new.save_showtimes
    def save_showtimes
      Cinema.all.each do |cinema|
        response = showtimes(cinema.external_id)
        response.each do |showtime|
          movie = Movie.find_or_create_by!(external_id: showtime[:movie_id])
          cinema.showtimes.find_or_create_by!(external_id: showtime[:id], movie: movie) do |new_showtime|
            new_showtime.start_at = showtime[:start_at].in_time_zone('Paris').strftime("%Y-%m-%dT%H:%M:00")
            new_showtime.start_date = new_showtime.start_at.to_date
            new_showtime.end_at = new_showtime.start_at + movie.running_time * 60 if movie.running_time
            new_showtime.language = showtime[:language]
            new_showtime.subtitle_language = showtime[:subtitle_language]
            new_showtime.auditorium = showtime[:auditorium]
            new_showtime.dimension = showtime_dimension(showtime)
            new_showtime.booking_type = showtime[:booking_type]
            new_showtime.booking_link = showtime[:booking_link]
            new_showtime.country_code = @country.iso_code
          end 
        end
      end
    end

    # Showtimes we can't find anymore on the API
    # Api::InternationalShowtimes::Import.new.purge_old_showtimes
    def purge_old_showtimes
      Showtime.upcoming.each do |showtime|
        response = showtime_details(showtime.external_id)
        showtime.destroy if response.dig(:error, :code) == 10007
      end
    end

    def showtime_dimension(showtime)
      return '3D' if showtime[:is_3d]
      return 'IMAX' if showtime[:is_imax]
      return 'IMAX 3D' if showtime[:is_3d] && showtime[:is_imax]
      '2D'
    end
  end
end
