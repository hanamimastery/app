# frozen_string_literal: true

module Main
  module Views
    module Scopes
      module Shared
        class Flash < Main::Views::Scope
          def message
            return flash[:notice] if flash[:notice]

            return flash[:alert] if flash[:alert]
          end

          def notification_class
            return "is-success" if flash[:notice]

            return "is-danger" if flash[:alert]
          end

          def visible?
            flash[:notice] || flash[:alert]
          end
        end
      end
    end
  end
end
