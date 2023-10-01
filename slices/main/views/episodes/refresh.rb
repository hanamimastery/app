# frozen_string_literal: true

module Main
  module Views
    module Episodes
      # Renders Fetch view.
      class Refresh < Main::ViewHTMX
        expose :episode
      end
    end
  end
end
