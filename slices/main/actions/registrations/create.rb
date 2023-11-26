# frozen_string_literal: true

module Main
  module Actions
    module Registrations
      class Create < Main::Action
        params do
          required(:registration).hash do
            required(:nickname).filled(:string)
            required(:password).filled(:string)
            required(:password_confirmation).filled(:string)
            required(:tac).filled(:bool, eql?: true)
          end
        end

        before :validate!

        def handle(request, response)
            response.flash[:notice] = "Account successfully registered!"
            response.redirect(routes.path(:root))
        end
      end
    end
  end
end
