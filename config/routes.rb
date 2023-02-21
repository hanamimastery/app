# frozen_string_literal: true

module Hanamimastery
  # Configures application routes.
  class Routes < Hanami::Routes
    slice :main, at: '/' do
      root to: 'home.show'
      post '/subscribe', to: 'home.subscribe'

      get '/episodes', to: 'episodes.index'
    end
  end
end
