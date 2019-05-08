# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
set :output, { error: "log/cron_error.log" , standard: 'log/cron.log' }

every :day, at: '10am' do
  rake 'movie:notify_released'
end

# Learn more: http://github.com/javan/whenever
