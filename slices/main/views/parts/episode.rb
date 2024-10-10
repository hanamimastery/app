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

        def content(view_type)
          value.content
        end
      end
    end
  end
end
