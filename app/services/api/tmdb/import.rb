# Api::Tmdb::Import.new.perform
module Api::Tmdb
  class Import < Base

    def perform
      save_posters
      save_trailers
    end

    # Api::Tmdb::Import.new.save_posters
    def save_posters
      Movie.have_tmdb_id.dont_have_images.each do |movie|
        Country.all.each do |country|
          @movie_db = movie_details(movie.tmdb_id, {language: country.language})
          if @movie_db[:poster_path]
            movie_translation = movie.movie_translations.find_or_create_by(language: country.language)
            movie_translation.poster_url ||= "https://image.tmdb.org/t/p/original#{@movie_db[:poster_path]}"
            movie_translation.thumbnail_url ||= "https://image.tmdb.org/t/p/w342#{@movie_db[:poster_path]}"
            movie_translation.thumbnail_url ||= "https://image.tmdb.org/t/p/w185#{@movie_db[:poster_path]}"
            movie_translation.save
          end

          if @movie_db[:backdrop_path]
            movie.backdrop_url ||= "https://image.tmdb.org/t/p/original#{@movie_db[:backdrop_path]}"
            movie.backdrop_min_url ||= "https://image.tmdb.org/t/p/w780#{@movie_db[:backdrop_path]}"
            movie.save
          end
        end
      end
    end

    # Api::Tmdb::Import.new.save_trailers
    def save_trailers
      Country.all.each do |country|
        movies = Movie.have_tmdb_id.dont_have_trailers_in(country.language)
        movies.each do |movie|
          videos = movie_trailers(movie.tmdb_id, {language: country.language})
          next unless videos[:results]
          trailers = videos[:results].select { |video| video[:type] == 'Trailer' }
          if trailers.any?
            trailers.each do |trailer|
              url = "https://www.youtube.com/watch?v=#{trailer[:key]}"
              movie.trailers.find_or_create_by!(language: country.language, format: trailer[:site].downcase, url: url) do |new_trailer|
                new_trailer.transfert = trailer[:size]
              end
            end
          end
        end
      end
    end
  end
end
