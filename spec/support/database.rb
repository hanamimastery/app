# frozen_string_literal: true

module Test
  # Provides convenience methods for testing purposes.
  module App
    module Database
      def self.relations = rom.relations

      def self.rom = Hanami.app['db.rom']

      def self.db = Hanami.app['db.gateway'].connection
    end
  end

  module Main
    module Database
      def self.relations = rom.relations

      def self.rom = ::Main::Slice['db.rom']

      def self.db = ::Main::Slice['db.gateway'].connection
    end
  end
end

require 'database_cleaner/sequel'

using Refinements::Pathnames

DatabaseCleaner[:sequel].strategy = :transaction

RSpec.configure do |config|
  config.include Test::App::Database, :app_db
  config.include Test::Main::Database, :main_db

  config.before :suite do
    Hanami.app.start :db
  end

  config.before :each do
    DatabaseCleaner[:sequel].clean_with :truncation
  end

  config.prepend_before :each, :app_db do |example|
    DatabaseCleaner[:sequel].strategy = example.metadata[:js] ? :truncation : :transaction
    DatabaseCleaner[:sequel].start
  end

  config.prepend_before :each, :main_db do |example|
    DatabaseCleaner[:sequel].strategy = example.metadata[:js] ? :truncation : :transaction
    DatabaseCleaner[:sequel].start
  end

  config.append_after(:each, :app_db) { DatabaseCleaner[:sequel].clean }
  config.append_after(:each, :main_db) { DatabaseCleaner[:sequel].clean }
end
