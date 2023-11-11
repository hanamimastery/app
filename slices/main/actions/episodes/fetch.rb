# frozen_string_literal: true

module Main
  module Actions
    module Episodes
      class Fetch < Main::Action
        include Deps[
          interactor: 'interactors.fetch_draft_episodes'
        ]

        def handle(_request, response)
          result = interactor.call
          response.body = response.render view, episodes: result.value![:drafts]
        end
      end
    end
  end
end
