# frozen_string_literal: true

module Hanamimastery
  # Configures application settings.
  class Settings < Hanami::Settings
    setting :database_url
    setting :google_drive_id
    setting :google_application_credentials
  end
end
