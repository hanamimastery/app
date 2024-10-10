# frozen_string_literal: true

require 'bcrypt'

module Main
  module Actions
    module Sessions
      class Create < Main::ActionPublic
        include Deps['repos.accounts']

        model :session

        params do
          required(:session).hash do
            required(:nickname).filled(:string)
            required(:password).filled(:string)
          end
        end

        before :validate!

        def handle(request, response)
          params = request.params[model_name]
          account = fetch(params, response)

          verify_password(account.encrypted_password, params, response)

          response.flash[:notice] = "You're successfully logged in!"
          response.session[:current_user_id] = account.id
          response.redirect(routes.path(:episodes))
        end

        private

        def fetch(params, response)
          account = accounts.by_nickname(params[:nickname])

          return account if account

          response.flash.now[:alert] = "Invalid credentials for username"
          body = response.render(
            view,
            model: params,
            errors: { nickname: ['cannot be found'] }
          )

          halt 401, body
        end

        def verify_password(encrypted, params, response)
          return if BCrypt::Password.new(encrypted) == params[:password]

          response.flash.now[:alert] = "Invalid credentials"

          body = response.render(
            view,
            model: params,
            errors: { password: ['is not correct'] }
          )
          halt 401, body
        end
      end
    end
  end
end
