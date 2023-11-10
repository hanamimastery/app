# frozen_string_literal: true

module Main
  module Views
    module Episodes
      # Renders index view.
      class Index < Main::View
        include Deps[repo: 'repositories.episodes']

        expose :episodes do
          repo.recent
        end
      end
    end
  end
end
