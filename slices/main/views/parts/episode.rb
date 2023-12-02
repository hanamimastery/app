# frozen_string_literal: true

module Main
  module Views
    module Parts
      class Episode < Part
        def status_icon
          case value.status
          when Main::Entities::Episode::STATUSES[:draft]
            '✍️'
          when Main::Entities::Episode::STATUSES[:scheduled]
            '⌛'
          when Main::Entities::Episode::STATUSES[:published]
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
