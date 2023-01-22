# frozen_string_literal: true

module Main
  module Actions
    module Home
      # Subscribes to Youtube Channel
      class Subscribe < Main::Action
        def handle(*, response)
          response.body = 'Subscribed!'
        end
      end
    end
  end
end
