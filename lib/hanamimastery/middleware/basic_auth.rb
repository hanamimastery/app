# frozen_string_literal: true

module Hanamimastery
  module Middleware
    class BasicAuth
      def initialize(app)
        @app = app
      end

      def call(env)
        auth = Rack::Auth::Basic.new(@app) do |u, p|
          u == ENV['BASIC_AUTH_USERNAME'] && p == ENV['BASIC_AUTH_PASSWORD']
        end
        auth.call env
      end
    end
  end
end
