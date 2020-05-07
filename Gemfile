source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.4', '>= 5.2.4.2'
# Use postgresql as the database for Active Record
gem 'pg'
# Use Puma as the app server
gem 'puma'
# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false
# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors'
# Use Will Paginate and API Pagination for collection pagination
gem 'will_paginate'
gem 'api-pagination'
# Use Money-Rails for handling currency
gem 'money-rails'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  # Use RSpec for specs
  gem 'rspec-rails'
  # Use Factory Bot for generating random test data
  gem 'factory_bot_rails'
  # Use Faker to generate fake data
  gem 'faker'
  # Use SimpleCov for code coverage analysis
  gem 'simplecov', require: false
  # Use Database Cleaner for cleaning database between test examples
  gem 'database_cleaner-active_record'
end

group :development do
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'listen'
  gem 'spring-watcher-listen'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
