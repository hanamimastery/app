# frozen_string_literal: true
require 'byebug'
module Main
  module Actions
    module Episodes
      class Index < Main::Action
        include Deps[repo: 'repositories.episodes']

        def handle(*, response)
          episodes = repo.recent
          response.body = response.render view, episodes: episodes
        end
      end
    end
  end
end
