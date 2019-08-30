# Api::AfterCredits::Import.perform
module Api::AfterCredits
  class Import < Base
    def self.perform
      save_movies
    end

    private
    def self.save_movies
      Movie.where(after_credits: nil, during_credits: nil).each do |movie|
        response = Api::AfterCredits::Base.movie_details(movie.title('en'))
        set_not_after_credits(movie) and next if response.empty?

        set_after_credits(movie, response.first) and next if response.size == 1

        match_by_date(movie, response)
      end
    end

    def self.set_after_credits(movie, response_movie)
      during_credits = response_movie['duringCredits']&.downcase
      after_credits = response_movie['yesOrNo']&.downcase
      movie.update(after_credits: after_credits, during_credits: during_credits)
    end

    def self.set_not_after_credits(movie)
      movie.update(after_credits: 'no', during_credits: 'no')
    end

    def self.match_by_date(movie, response)
      movie_country = movie.movie_countries.first
      return unless movie_country

      year = movie_country.release_date.year
      response_movies = response.select{|x| x['releaseDate'] && x['releaseDate']['iso'].include?(year.to_s)}

      set_after_credits(movie, response.first) if response_movies.size == 1
    end
  end
end
