namespace :movie do
  desc "Notifies users when movie is released"
  task international_showtimes_imports: :environment do
    Api::InternationalShowtimes::Import.new.perform
  end

  task tmdb_imports: :environment do
    Api::Tmdb::Import.new.perform
  end
end
