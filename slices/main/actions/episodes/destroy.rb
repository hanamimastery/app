# frozen_string_literal: true

module Main
  module Actions
    module Episodes
      class Destroy < Main::Action
        include Deps['repositories.episodes']

        params do
          required(:id).value(:string)
        end

        def handle(request, response)
          episodes.delete(request.params[:id])
          response.redirect(routes.path(:episodes))
        end
      end
    end
  end
end
