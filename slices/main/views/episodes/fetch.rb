# frozen_string_literal: true

module Main
  module Views
    module Episodes
      # Renders Fetch view.
      class Fetch < Main::ViewHTMX
        expose :episodes
      end
    end
  end
end
