# Api::InternationalShowtimes::Import.new.perform
module Api::InternationalShowtimes
  class Import < Base
    def perform
      save_genres
      save_cities
      save_chains
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
  end
end
