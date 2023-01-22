# frozen_string_literal: true

RSpec.configure do |config|
  config.color = true

  config.expect_with :rspec do |expectations|
    expectations.syntax = :expect
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_doubled_constant_names = true
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  config.filter_run_when_matching :focus

  config.disable_monkey_patching!
  config.example_status_persistence_file_path = './tmp/rspec-examples.txt'
  config.warnings = true

  config.default_formatter = 'doc' if config.files_to_run.one?

  config.formatter = ENV.fetch('CI', false) == 'true' ? :progress : :documentation

  config.profile_examples = 10

  config.order = :random
  Kernel.srand config.seed
end
