# frozen_string_literal: true

require 'hanami'

module Hanamimastery
  # Handles HTTP requests.
  class App < Hanami::App
    config.actions.content_security_policy[:script_src] = 'https://unpkg.com'
    config.actions.content_security_policy[:style_src] = 'https://cdn.jsdelivr.net'
    config.middleware.use Hanamimastery::Middleware::BasicAuth

    environment(:development) do
      require 'byebug'
    end
  end
end
