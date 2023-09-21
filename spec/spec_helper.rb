# frozen_string_literal: true

require 'pathname'
SPEC_ROOT = Pathname(__dir__).realpath.freeze

require 'bundler/setup'
Bundler.require :tools

require 'simplecov'

unless ENV['NO_COVERAGE']
  SimpleCov.start do
    add_filter %r{^/spec/}
    enable_coverage :branch
    enable_coverage_for_eval
    minimum_coverage_by_file line: 95, branch: 95
  end
end

require 'refinements'

using Refinements::Pathnames

ENV['HANAMI_ENV'] ||= 'test'
require 'hanami/prepare'

Pathname.require_tree __dir__, 'support/shared_contexts/**/*.rb'
Pathname.require_tree __dir__, 'support/mocks/**/*.rb'

require_relative 'support/rspec'

require_relative 'support/database'
require_relative 'support/factory'

require_relative 'support/requests'
require_relative 'support/web'
