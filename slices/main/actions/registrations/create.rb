# frozen_string_literal: true

module Main
  module Actions
    module Registrations
      class Create < Main::Action
        params do
          required(:registration).hash do
            required(:username).filled(:string)
            required(:password).filled(:string)
            required(:password_confirmation).filled(:string)
            required(:tac).filled(:bool)
          end
        end

        def handle(request, response)
          if request.params.valid?
            response.flash[:notice] = "Account successfully registered!"
          else
            request.params.errors
            response.flash[:error] = "Error occured while creating the account"
          end
        end
      end
    end
  end
end
