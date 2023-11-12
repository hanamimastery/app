# frozen_string_literal: true

module Main
  module Actions
    module Registrations
      class Create < Main::Action
        def handle(request, response)
          # response.flash[:error] = "Not implemented"
          response.flash[:notice] = "Account registered!"
        end
      end
    end
  end
end
