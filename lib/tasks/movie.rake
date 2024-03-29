namespace :movie do
  desc "Notifies users when movie is released"
  task notify_released: :environment do
puts "NOTIFY RELEASE BEGIN: #{Time.now}"
Rails.logger.info 'RAILS LOGGER INFO TEST'
    movie_ids = MovieCountry.where(iso_code: 'FR', release_date: Date.today).pluck(:movie_id)
    movies = Movie.where(id: movie_ids)
    movies.each do |movie|
      movie.watchlisted_by_users.each do |user|
        Notification.create(recipient: user, actorable: movie, action: :movie_released, notifiable: movie)
      end
    end
puts "NOTIFY RELEASE END: #{Time.now}"
  end
end
