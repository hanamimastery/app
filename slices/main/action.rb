# auto_register: false
# frozen_string_literal: true

module Main
  # The main action.
  class Action < Hanamimastery::Action
    include Hanamimastery::Utils::Pagination

    before :authenticate!

    private

    # Enforces user to be logged in
    #
    def authenticate!(request, response)
      return if authenticated?(request)

      response.flash[:alert] = "You need to login in order to browse the requested resource"
      response.redirect_to(routes.path(:login))
    end

    def authenticated?(request)
      !request.session[:current_user_id].nil?
    end
  end
end
