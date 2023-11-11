# frozen_string_literal: true

require 'simplecov'

SimpleCov.start do
  add_filter %r{^/spec/}
  enable_coverage :branch
  enable_coverage_for_eval
  minimum_coverage_by_file line: 95, branch: 95
end
