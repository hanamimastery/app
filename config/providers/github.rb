# frozen_string_literal: true

Hanami.app.register_provider :github, namespace: true do
  prepare do
    require 'octokit'

    client = Octokit::Client.new(
      access_token: target['settings'].github_access_token
    )

    register 'client', client
  end
end
