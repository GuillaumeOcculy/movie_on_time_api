# Api::InternationalShowtimes::Import.new.perform
module Api::InternationalShowtimes
  class Import < Base
    def perform
      save_genres
    end

    # Api::InternationalShowtimes::Import.new.save_genres
    def save_genres
      genres.each do |genre|
        Genre.find_or_create_by(external_id: genre[:id], name: genre[:name])
      end
    end
  end
end
