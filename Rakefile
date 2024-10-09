# frozen_string_literal: true

require 'bundler/setup'
require "hanami/rake_tasks"

require 'reek/rake/task'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'

Reek::Rake::Task.new
RSpec::Core::RakeTask.new
RuboCop::RakeTask.new

desc 'Run code quality checks'
task analyze: %i[reek rubocop]

task default: %i[analyze spec]
