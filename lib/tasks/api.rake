namespace :api do
  desc "Fetch informations from APIs"
  task international_showtimes_imports: :environment do
    Api::InternationalShowtimes::Import.new.perform
  end

  task tmdb_imports: :environment do
    Api::Tmdb::Import.new.perform
  end
end
