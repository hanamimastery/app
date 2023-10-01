# frozen_string_literal: true

module Main
  module Actions
    module Episodes
      class Refresh < Main::Action
        include Deps[
          interactor: 'interactors.refresh_episode'
        ]

        def handle(request, response)
          result = interactor.call(request.params[:id])
          response.body = response.render view, episode: result.value![:episode]
        end
      end
    end
  end
end
