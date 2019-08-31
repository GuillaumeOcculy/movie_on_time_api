namespace :api do
  desc "Fetch informations from APIs"
  task international_showtimes_imports: :environment do
    Api::InternationalShowtimes::Import.new.perform
  end

  task purge_old_showtimes: :environment do
    Api::InternationalShowtimes::Import.new.purge_old_showtimes
  end

  task tmdb_imports: :environment do
    Api::Tmdb::Import.new.perform
  end

  task after_credits_imports: :environment do
    Api::AfterCredits::Import.perform
  end

  task clear_cache: :environment do
    Rails.cache.clear
  end
end
