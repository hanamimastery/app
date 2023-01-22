# frozen_string_literal: true

module Hanamimastery
  # Configures application settings.
  class Settings < Hanami::Settings
    setting :database_url
  end
end
