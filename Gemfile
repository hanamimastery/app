# frozen_string_literal: true

ruby '3.2.0'

source 'https://rubygems.org'

gem 'dry-effects'
gem 'dry-monads'
gem 'dry-matcher'
gem 'dry-transformer', github: 'dry-rb/dry-transformer', branch: 'main'
gem 'dry-types', '~> 1.7'
gem 'erbse', '~> 0.1'

gem 'googleauth'
gem 'google-apis-drive_v3'

gem 'hanami', github: 'hanami/hanami', branch: 'main'
gem 'hanami-router', github: 'hanami/router', branch: 'main'
gem 'hanami-controller', github: 'hanami/controller', branch: 'main'
gem 'hanami-validations', github: 'hanami/validations', branch: 'main'
gem 'hanami-view', github: 'hanami/view', branch: 'main'
gem 'hanami-assets', github: 'hanami/assets', branch: 'main'

gem 'front_matter_parser'
gem 'octokit'

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

group :cli, :development do
  gem "hanami-reloader", "~> 2.1.0.rc"
end

group :cli, :development, :test do
  gem "hanami-rspec", "~> 2.1.0.rc"
end

group :development, :test do
  gem 'byebug'
  gem 'dotenv', '~> 2.8'
  gem 'hanami-webconsole', github: 'hanami/webconsole', branch: 'main'
end

group :development do
  gem 'localhost', '~> 1.1'
  gem 'rake', '~> 13.0'
  gem 'rerun', '~> 0.14'
  gem "guard-puma"
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
