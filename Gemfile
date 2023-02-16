# frozen_string_literal: true

ruby '3.2.0'

source 'https://rubygems.org'

gem 'dry-types', '~> 1.7'
gem 'erbse', '~> 0.1'

gem 'googleauth'
gem 'google-apis-drive_v3'

gem 'hanami', '~> 2.0'
gem 'hanami-controller', '~> 2.0'
gem 'hanami-router', '~> 2.0'
gem 'hanami-validations', '~> 2.0'
gem 'hanami-view', github: 'hanami/view', branch: 'main'
gem 'pg', '~> 1.4'
gem 'puma', '~> 6.0'
gem 'refinements', '~> 10.0'
gem 'rom', '~> 5.3'
gem 'rom-sql', '~> 3.6'
gem 'sequel', '~> 5.64'

group :analyze do
  gem 'caliber', '~> 0.21'
  gem 'reek', '~> 6.1'
  gem 'rubocop-sequel', '~> 0.3'
  gem 'simplecov', '~> 0.22', require: false
end

group :development, :test do
  gem 'dotenv', '~> 2.8'
end

group :development do
  gem 'localhost', '~> 1.1'
  gem 'rake', '~> 13.0'
  gem 'rerun', '~> 0.14'
end

group :test do
  gem 'capybara', '~> 3.38'
  gem 'cuprite', '~> 0.14'
  gem 'database_cleaner-sequel', '~> 2.0'
  gem 'guard-rspec', '~> 4.7', require: false
  gem 'hanami-rspec', '~> 2.0'
  gem 'launchy', '~> 2.5'
  gem 'rack-test', '~> 2.0'
  gem 'rom-factory', '~> 0.11'
end

group :tools do
  gem 'amazing_print', '~> 1.4'
  gem 'debug', '~> 1.7'
end
