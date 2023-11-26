# frozen_string_literal: true

module Main
  module Views
    module Helpers
      def flash_message
        flash_scope = scope(Scopes::Notification, notification: _context.flash)
        return if flash_scope.hidden?

        flash_scope.render('layouts/flash_msg')
      end
    end
  end
end
