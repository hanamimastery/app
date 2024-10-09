# frozen_string_literal: true

Hanami.app.configure_provider :db do
  # Explicitly configure a gateway
  # config.gateway :artifacts do |gw|
  #   # If not configured, will still be filled from `ENV["DATABASE_URL__ARTIFACTS"]`
  #   gw.database_url = "..."

  #   # Specify an adapter to use
  #   gw.adapter :yaml

  #   # Or configure an adapter explicitly
  #   gw.adapter :yaml do |a|
  #     # You can call `a.plugin` here
      # Or also `a.extension` if this is an `:sql` adapter
  #   end
  # end

  # # Multiple gateways can be configured
  # config.gateway :another do |gw|
  #   # ...
  # end
  config.adapter :sql do |adapter|
    adapter.plugin(relations: :pagination)
  end
end
