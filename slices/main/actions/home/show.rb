# frozen_string_literal: true

module Main
  module Actions
    module Home
      # Processes show action.
      class Show < Main::Action
        def handle(*, response) = response.render view
      end
    end
  end
end
