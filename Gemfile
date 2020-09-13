# frozen_string_literal: true

source 'https://rubygems.org'

# Webserver
gem 'bugsnag'      # For send exception to BugSnag
gem 'puma'
gem 'rack'
gem 'rack-contrib' # For convert request body to params see ./config.ru
gem 'rack-cors'    # For enable CORS ./config.ru

# Framework
gem 'sinatra'
gem 'sinatra-contrib'
gem 'zeitwerk' # For autoload path see ./config/boot.rb
gem 'luna_park', git: 'git@github.com:am-team/luna_park.git'
gem 'jsonapi-serializers'

# Validators
gem 'dry-validation'

# Models
gem 'pg', '~> 0.18'
gem 'sequel'

# System
gem 'rack-rewrite'
gem 'racksh'
gem 'rake'
gem 'rest-client'

group :development, :test do
  gem 'debase'
  gem 'factory_bot'
  gem 'pry'
  gem 'rack-test'
  gem 'rerun' # Code autoreload after change files in dev mode
  gem 'rspec'
  gem 'rubocop'
end

group :test do
  gem 'database_cleaner'
  gem 'rspec-json_expectations'
  gem 'webmock'
end

group :development do
  # Capistrano deploy need it
  gem 'capistrano', '~> 3.11',        require: false
  gem 'capistrano-bundler', '~> 1.4', require: false
  gem 'capistrano-rvm',               require: false

  # For show slack msg after deploy
  gem 'slack-notifier',               require: false

  # For username who init deploy at slack, catch name from git config
  gem 'git',                          require: false
end
