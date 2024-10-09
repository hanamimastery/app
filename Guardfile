# frozen_string_literal: true

guard :rspec, cmd: 'NO_COVERAGE=true bundle exec rspec --format documentation' do
  require 'guard/rspec/dsl'

  dsl = Guard::RSpec::Dsl.new self

  # Ruby
  ruby = dsl.ruby
  dsl.watch_spec_files_for ruby.lib_files

  # RSpec
  rspec = dsl.rspec
  watch rspec.spec_files

  # Hanami
  watch(rspec.spec_helper) { rspec.spec_dir }
  watch(%r{^spec/hanami_helper.rb$}) { rspec.spec_dir }
  watch(%r{^app/(.+)\.rb$}) { |result| rspec.spec.call("app/#{result[1]}") }
  watch(%r{^slices/(.+)\.rb$}) { |result| rspec.spec.call("slices/#{result[1]}") }
end

group :server do
  guard "puma", port: ENV.fetch("HANAMI_PORT", 2300) do
    # Edit the following regular expression for your needs.
    # See: https://guides.hanamirb.org/app/code-reloading/
    watch(%r{^(app|config|lib|slices)([\/][^\/]+)*.(rb|erb|haml|slim)$}i)
  end
end
