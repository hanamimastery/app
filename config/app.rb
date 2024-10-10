# frozen_string_literal: true

require 'hanami'

# require 'hanamimastery/middleware/basic_auth'

module Hanamimastery
  # Handles HTTP requests.
  class App < Hanami::App
    config.actions.content_security_policy[:script_src] = [
      'self',
      'https://unpkg.com',
      'localhost:2300',
      'https://kit.fontawesome.com'
    ].join(' ')

    config.actions.content_security_policy[:connect_src] = [
      'self',
      'localhost:2300',
      'https://ka-f.fontawesome.com'
    ].join(' ')

    config.actions.content_security_policy[:font_src] = [
      'self',
      'localhost:2300',
      'https://ka-f.fontawesome.com'
    ].join(' ')

    config.actions.content_security_policy[:style_src] = [
      'self',
      "'unsafe-inline'",
      'https://cdn.jsdelivr.net',
      'localhost:2300'
    ].join(' ')

    config.actions.sessions = :cookie, {
      key: "hanamimastery.session",
      secret: settings.session_secret,
      expire_after: 60*60*24*365
    }

    # config.middleware.use Hanamimastery::Middleware::BasicAuth unless Hanami.env == :test

    config.render_error_responses.merge!(
      "Errors::RecordNotFound" => :not_found
    )

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
