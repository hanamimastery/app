# frozen_string_literal: true

require 'pathname'
SPEC_ROOT = Pathname(__dir__).realpath.freeze

require 'bundler/setup'
Bundler.require :tools

require 'support/simplecov' unless ENV['NO_COVERAGE']

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
