source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.2'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.11'

# Type casting
gem 'activerecord-typedstore'

# Parsing
gem 'oj'

# Multi environment settings
gem 'config'

# Geolocation
gem 'geocoder'

# API
gem 'httparty'
gem 'versionist'
gem 'fast_jsonapi'
gem 'rails_param'

# Paginations
gem 'api-pagination'
gem 'will_paginate'

# Authentification
gem 'devise'
gem 'jwt'

# Cron
gem 'whenever', require: false

# Jobs
gem 'sidekiq'

# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'bullet'
  gem 'pry'
  gem 'letter_opener'

  gem 'rspec-rails', '~> 3.8'
  gem 'shoulda-matchers'
  gem 'factory_bot_rails', '~> 4.10.0'
  gem 'faker', :git => 'https://github.com/stympy/faker.git', :branch => 'master'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'

  gem 'spring-commands-rspec'
  gem 'guard-rspec', require: false

  gem 'capistrano',         require: false
  gem 'capistrano-rvm',     require: false
  gem 'capistrano-rails',   require: false
  gem 'capistrano-bundler', require: false
  gem 'capistrano3-puma',   require: false
  gem 'capistrano-dotenv-tasks', require: false
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

