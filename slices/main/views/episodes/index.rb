# frozen_string_literal: true

module Main
  module Views
    module Episodes
      # Renders show view.
      class Index < Main::View
        expose :episodes
      end
    end
  end
end
