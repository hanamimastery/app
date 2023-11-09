# frozen_string_literal: true

require 'bundler/setup'
require 'hanami/rake_tasks'
require 'reek/rake/task'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'

Reek::Rake::Task.new
RSpec::Core::RakeTask.new
RuboCop::RakeTask.new

desc 'Run code quality checks'
task analyze: %i[reek rubocop]

task default: %i[analyze spec]

task :environment do
  require_relative "config/app"
  require "hanami/prepare"
end

namespace :db do
  task setup: :environment do
    Hanami.app.prepare :persistence
    config = Hanami.app['persistence.config']
    ROM::SQL::RakeSupport.env = ROM.container(config)
  end

  task seed: :setup do
    require Hanamimastery::App.root.join('db/seed.rb').to_s
  end
end
