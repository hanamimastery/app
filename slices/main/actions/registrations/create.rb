# frozen_string_literal: true

module Main
  module Actions
    module Registrations
      class Create < Main::ActionPublic
        include Deps[
          'repos.accounts',
          'transformations.account_to_db'
        ]

        model :registration

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
          account = accounts.create(account_to_db.call(request.params[model_name]))
          response.session[:current_user_id] = account.id

          response.redirect(routes.path(:root))
        end
      end
    end
  end
end
