# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
set :output, { error: "log/cron_error.log" , standard: 'log/cron.log' }

every 1.day, at: ['6:30 am', '8:00pm'] do
  rake "api:international_showtimes_imports", environment: :production
end

every 1.day, at: ['9:30 am', '8:00pm'] do
  rake "api:tmdb_imports", environment: :production
end

every :day, at: '10am' do
  rake 'movie:notify_released'
end

# Learn more: http://github.com/javan/whenever
