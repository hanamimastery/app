# frozen_string_literal: true

require 'rack/test'

RSpec.configure do |config|
  config.include Rack::Test::Methods, type: :request
  config.include_context 'with Hanami application', type: :request
end
