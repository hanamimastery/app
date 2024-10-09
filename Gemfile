# frozen_string_literal: true

ruby '3.3.5'

source 'https://rubygems.org'

gem 'dry-effects'
gem 'dry-matcher'
gem 'dry-monads'
gem 'dry-transformer', github: 'dry-rb/dry-transformer', branch: 'main'
gem "dry-types", "~> 1.0", ">= 1.6.1"
gem 'erbse', '~> 0.1'

gem 'google-apis-drive_v3'
gem 'googleauth'

gem "hanami", "~> 2.2.0.beta"
gem "hanami-assets", "~> 2.2.0.beta"
gem "hanami-controller", "~> 2.2.0.beta"
gem "hanami-db", "~> 2.2.0.beta"
gem "hanami-router", "~> 2.2.0.beta"
gem "hanami-validations", "~> 2.2.0.beta"
gem "hanami-view", "~> 2.2.0.beta"

gem 'front_matter_parser'
gem 'octokit'
gem "ostruct" # extracted from standard ruby library for Ruby 3.5 compatibility

gem 'pg', '~> 1.4'
gem 'puma', '~> 6.0'
gem 'refinements', '~> 10.0'

group :analyze do
  gem 'caliber', '~> 0.21'
  gem 'reek', '~> 6.1'
  gem 'rubocop-sequel', '~> 0.3'
  gem 'simplecov', '~> 0.22', require: false
end

group :cli, :development do
  gem "hanami-reloader", "~> 2.2.0.beta"
end

group :cli, :development, :test do
  gem "hanami-rspec", "~> 2.2.0.beta"
end

group :development, :test do
  gem 'byebug'
  gem 'dotenv', '~> 2.8'
end

group :development do
  gem 'guard-puma'
  gem 'localhost', '~> 1.1'
  gem 'rake', '~> 13.0'
  gem 'rerun', '~> 0.14'
  gem "hanami-webconsole", "~> 2.2.0.beta"
end

group :test do
  gem 'capybara', '~> 3.38'
  gem 'cuprite', '~> 0.14'
  gem 'database_cleaner-sequel', '~> 2.0'
  gem 'guard-rspec', '~> 4.7', require: false
  gem 'launchy', '~> 2.5'
  gem 'rack-test', '~> 2.0'
  gem 'rom-factory', '~> 0.11'
end

group :tools do
  gem 'amazing_print', '~> 1.4'
  gem 'debug', '~> 1.7'
end
