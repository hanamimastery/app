# frozen_string_literal: true

module Main
  module Views
    module Scopes
      # @usage
      #  scope(Notification).
      #    render('layouts/notification', notification: { alert: 'This is the error'}).
      #
      class Notification < Main::Views::Scope
        def message
          return '' if hidden?

          notification[:notice] || notification[:alert]
        end

        def notification_class
          return 'is-hidden' if hidden?

          notification[:notice] ? 'is-success' : 'is-danger'
        end

        def hidden?
          !(notification[:notice] || notification[:alert])
        end
      end
    end
  end
end
