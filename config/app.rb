# frozen_string_literal: true

require 'hanami'

require 'hanamimastery/middleware/basic_auth'

module Hanamimastery
  # Handles HTTP requests.
  class App < Hanami::App
    config.actions.content_security_policy[:script_src] = "'self' https://unpkg.com https://kit.fontawesome.com"

    config.actions.content_security_policy[:connect_src] = "'self' https://ka-f.fontawesome.com"

    config.actions.content_security_policy[:font_src] = "'self' https://ka-f.fontawesome.com"

    config.actions.content_security_policy[:style_src] = "'self' 'unsafe-inline' https://cdn.jsdelivr.net"

    config.middleware.use Hanamimastery::Middleware::BasicAuth

    config.shared_app_component_keys += ['github.client', 'parsers.front_matter']

    config.inflections do |inflections|
      inflections.acronym 'DB'
      inflections.acronym 'HTMX'
    end

    # :nocov:
    environment(:development) do
      require 'byebug'
    end
    # :nocov:
  end
end
