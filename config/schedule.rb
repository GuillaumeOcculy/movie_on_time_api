# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
set :output, { error: "log/cron_error.log" , standard: 'log/cron.log' }

every 1.day, at: '6:30 am' do
  rake "api:international_showtimes_imports", environment: :production
end

every 1.day, at: '10:30 am' do
  rake "api:purge_old_showtimes", environment: :production
end

every 1.day, at: '9:30 am' do
  rake "api:tmdb_imports", environment: :production
end

every :day, at: '10am' do
  rake 'api:clear_cache', environment: :production
end

every :day, at: '11:30 am' do
  rake 'movie:notify_released', environment: :production
end

# Learn more: http://github.com/javan/whenever
