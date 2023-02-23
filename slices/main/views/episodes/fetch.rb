# frozen_string_literal: true

module Main
  module Views
    module Episodes
      # Renders Fetch view.
      class Fetch < Main::View
        config.layout = false
        expose :episodes
      end
    end
  end
end
