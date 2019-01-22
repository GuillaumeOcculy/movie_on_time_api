# Api::InternationalShowtimes::Import.new.perform
module Api::InternationalShowtimes
  class Import < Base
    def perform
      save_genres
      save_cities
    end

    # Api::InternationalShowtimes::Import.new.save_genres
    def save_genres
      genres.each do |genre|
        Genre.find_or_create_by(external_id: genre[:id], name: genre[:name])
      end
    end

    # Api::InternationalShowtimes::Import.new.save_cities
    def save_cities
      country = Country.find_or_create_by(name: 'France', iso_code: 'FR', language: 'fr')
      cities.each do |city|
        country.cities.find_or_create_by(external_id: city[:id], name: city[:name]) do |new_city|
          new_city.latitude = city[:lat]
          new_city.longitude = city[:lon]
          new_city.country_code = city[:country]
        end
      end
    end
  end
end
