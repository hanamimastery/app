# frozen_string_literal: true

module Main
  module Views
    module Parts
      class Episode < Part
        def status_icon
          case value.status
          when Main::Structs::Episode::STATUSES[:draft]
            '✍️'
          when Main::Structs::Episode::STATUSES[:scheduled]
            '⌛'
          when Main::Structs::Episode::STATUSES[:published]
            '🌎'
          end
        end
      end
    end
  end
end
