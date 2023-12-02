# frozen_string_literal: true

module Main
  module Views
    module Episodes
      # Renders index view.
      class Show < Main::View
        include Deps[repo: 'repositories.episodes']

        expose :episode do |id:|
          repo.find(id)
        end

        expose :view
      end
    end
  end
end
