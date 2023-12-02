# frozen_string_literal: true

module Main
  # Configures application routes.
  class Routes < Hanami::Routes
    root to: 'home.show'
    post '/subscribe', to: 'home.subscribe'

    get '/episodes', to: 'episodes.index', as: :episodes
    post '/episodes/fetch', to: 'episodes.fetch', as: :fetch_episodes

    get '/episodes/:id', to: 'episodes.show', as: :episode
    get '/episodes/:id/:view', to: 'episodes.show', as: :episode_view
    patch '/episodes/:id/refresh', to: 'episodes.refresh', as: :refresh_episode

    get "/signup", to: "registrations.new", as: :signup
    post "/signup", to: "registrations.create", as: :register_account

    get "/login", to: "sessions.new", as: :login
    post "/login", to: "sessions.create", as: :authenticate
    get "/logout", to: "sessions.destroy", as: :logout
  end
end
