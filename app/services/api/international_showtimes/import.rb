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
      save_movie_details
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

    # Api::InternationalShowtimes::Import.new.save_movie_details
    def save_movie_details
      Movie.draft.find_in_batches do |movies|
        movies.each do |movie|
          response = movie_details(movie.external_id, @country.iso_code.downcase)
          next unless response

          movie.update!(original_title: response[:original_title], original_language: response[:original_language], running_time: response[:runtime], 
                        website: response[:website], imdb_id: response[:imdb_id], tmdb_id: response[:tmdb_id], rentrak_film_id: response[:rentrak_film_id], 
                        backdrop_url: backdrop_url(response), backdrop_min_url: backdrop_min_url(response))

          save_ratings(movie, response)
          save_movie_genres(movie, response)
          save_trailers(movie, response)
          save_casts(movie, response)
          save_directors(movie, response)

          Country.all.each do |country|
            response = movie_details(movie.external_id, country.language)

            movie.movie_translations.find_or_create_by(language: country.language) do |new_movie|
              new_movie.title = response[:title]
              new_movie.synopsis = response[:synopsis]
              new_movie.poster_url = poster_url(response)
              new_movie.thumbnail_url = thumbnail_url(response)
            end

            save_release_date(movie, country, response)
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

    private
    def backdrop_url(response)
      backdrop = nil
      scene_image = response[:scene_images]&.first

      if scene_image
        backdrop = scene_image[:image_files].find{ |x| x[:url].include?('original') }&.dig(:url) 
        backdrop['http://'] = 'https://' if backdrop
      end
      
      backdrop
    end

    def showtime_dimension(showtime)
      return '3D' if showtime[:is_3d]
      return 'IMAX' if showtime[:is_imax]
      return 'IMAX 3D' if showtime[:is_3d] && showtime[:is_imax]
      '2D'
    end
    
    def backdrop_min_url(response)
      backdrop_min = nil
      scene_image = response[:scene_images]&.first
      if scene_image
        backdrop_min = scene_image[:image_files].find{ |x| x[:url].include?('w780') }&.dig(:url) 
        backdrop_min['http://'] = 'https://' if backdrop_min
      end
      
      backdrop_min
    end

    def thumbnail_url(response)
      thumbnail = nil
      thumbnail = response.dig(:poster_image, :image_files)&.find{ |x| x[:url].include?('w342') }&.dig(:url)
      thumbnail['http://'] = 'https://' if thumbnail
      
      thumbnail
    end

    def poster_url(response)
      poster = nil
      poster = response.dig(:poster_image, :image_files)&.find{ |x| x[:url].include?('original') }&.dig(:url)
      poster['http://'] = 'https://' if poster
      
      poster
    end

    def save_ratings(movie, response)
      response[:ratings]&.each do |is_rating|
        movie.ratings.find_or_create_by(name: is_rating[0]) do |new_rating|
          new_rating.value = is_rating[1][:value]
          new_rating.vote_count = is_rating[1][:vote_count]
        end
      end
    end

    def save_movie_genres(movie, response)
      response[:genres].each do |is_genre|
        genre = Genre.find_or_create_by(external_id: is_genre[:id])
        MovieGenre.find_or_create_by!(genre: genre, movie: movie)
      end
    end

    def save_trailers(movie, response)
      response[:trailers]&.each do |trailer|
        file = trailer[:trailer_files][0]
        movie.trailers.find_or_create_by(format: file[:format], url: file[:url], language: trailer[:language]) do |new_trailer|
          new_trailer.transfert = file[:transfert]
        end
      end
    end

    def save_casts(movie, response)
      response[:cast]&.first(5)&.each do |cast|
        person = Person.find_or_create_by(external_id: cast[:id], name: cast[:name])
        movie.casts.find_or_create_by(external_id: cast[:id], name: cast[:name], character: cast[:character], person: person)
      end
    end

    def save_directors(movie, response)
      response[:crew]&.select{ |crew| crew[:job] == 'director' }&.each do |crew|
        person = Person.find_or_create_by(external_id: crew[:id], name: crew[:name])
        movie.directors.find_or_create_by(external_id: crew[:id], name: crew[:name], person: person)
      end
    end

    def save_release_date(movie, country, response)
      if release_date = response[:release_dates]&.find{ |date| date[0][country.iso_code] }
        MovieCountry.find_or_create_by(movie: movie, country: country, release_date: release_date[1][0][:date], iso_code: country.iso_code)
      end
    end
  end
end
