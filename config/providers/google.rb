# frozen_string_literal: true

Hanami.app.register_provider :google, namespace: true do
  prepare do
    require 'googleauth'

    scope = [
      'https://www.googleapis.com/auth/drive'
    ]

    authorizer =
      Google::Auth::ServiceAccountCredentials.from_env(scope:)
    register 'authorizer', authorizer

    require 'google/apis/drive_v3'
    drive = Google::Apis::DriveV3::DriveService.new

    register 'drive', drive
  end

  start do
    target['google.authorizer']
      .fetch_access_token!

    target['google.drive'].authorization = target['google.authorizer']
  end
end
