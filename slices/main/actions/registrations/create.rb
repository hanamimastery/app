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
            required(:tac).filled(:bool, eql?: true)
          end
        end

        def handle(request, response)
          if request.params.valid?
            response.flash[:notice] = "Account successfully registered!"
            response.redirect(routes.path(:root))
          else
            response.flash.now[:alert] = "Error occured while creating the account"
            response.render(
              view,
              registration: request.params[:registration],
              errors: request.params.errors[:registration]
            )
          end
        end
      end
    end
  end
end
