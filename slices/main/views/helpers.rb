# frozen_string_literal: true

module Main
  module Views
    module Helpers
      def flash_message
        scope('shared/flash', flash: _context.flash).render('layouts/flash_msg')
      end
    end
  end
end
