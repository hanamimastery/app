# frozen_string_literal: true

module Test
  # Provides convenience methods for testing purposes.
  module Database
    def self.relations = rom.relations

    def self.rom = Hanami.app['persistence.rom']

    def self.db = Hanami.app['persistence.db']
  end
end

require 'database_cleaner/sequel'

using Refinements::Pathnames

DatabaseCleaner[:sequel].strategy = :transaction

RSpec.configure do |config|
  config.include Test::Database, :db

  config.before :suite do
    Hanami.app.start :persistence
  end

  config.before :each do
    DatabaseCleaner[:sequel].clean_with :truncation
  end

  config.prepend_before :each, :db do |example|
    DatabaseCleaner[:sequel].strategy = example.metadata[:js] ? :truncation : :transaction
    DatabaseCleaner[:sequel].start
  end

  config.append_after(:each, :db) { DatabaseCleaner[:sequel].clean }
end
