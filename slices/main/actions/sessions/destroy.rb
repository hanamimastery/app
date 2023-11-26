# frozen_string_literal: true

module Main
  module Actions
    module Sessions
      class Destroy < Main::Action
        def handle(request, response)
          response.session[:current_user_id] = nil
          response.flash[:notice] = "You've been successfully logged out"
          response.redirect(routes.path(:login))
        end
      end
    end
  end
end
