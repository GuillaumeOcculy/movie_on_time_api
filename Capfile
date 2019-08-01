# Load DSL and set up stages
require "capistrano/setup"

# Include default deployment tasks
require "capistrano/deploy"

# Load the SCM plugin appropriate to your project:
require "capistrano/scm/git"
install_plugin Capistrano::SCM::Git

# Include tasks from other gems included in your Gemfile
require "capistrano/bundler"
require "capistrano/rails/migrations"
require "capistrano/rvm"
require "capistrano/puma"
require 'whenever/capistrano'
require 'capistrano/sidekiq'
require 'capistrano/sidekiq/monit' #to require monit tasks

install_plugin Capistrano::Puma

# Load custom tasks from `lib/capistrano/tasks` if you have any defined
Dir.glob("lib/capistrano/tasks/*.rake").each { |r| import r }
