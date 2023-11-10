# frozen_string_literal: true

module Main
  # Configures application routes.
  class Routes < Hanami::Routes
    root to: 'home.show'
    post '/subscribe', to: 'home.subscribe'

    get '/episodes', to: 'episodes.index', as: :episodes
    post '/episodes/fetch', to: 'episodes.fetch'

    patch '/episodes/:id/refresh', to: 'episodes.refresh'
  end
end
