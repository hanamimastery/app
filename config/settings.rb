# frozen_string_literal: true

module Hanamimastery
  # Configures application settings.
  class Settings < Hanami::Settings
    setting :database_url, constructor: Types::String
    setting :google_drive_id, constructor: Types::String
    setting :google_application_credentials, constructor: Types::String

    setting :github_access_token, constructor: Types::String

    setting :font_awesome_kit, constructor: Types::String
  end
end
