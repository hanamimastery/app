# auto_register: false
# frozen_string_literal: true

require 'hanami/action'

module Hanamimastery
  # The application action.
  class Action < Hanami::Action
    private

    def self.model(name)
      define_method(:model_name) { name }
    end

    def validate!(request, response)
      return if request.params.valid?

      response.flash.now[:alert] = "There were errors with your form validation"

      body = response.render(
        view,
        values: request.params[model_name],
        errors: request.params.errors[model_name]
      )
      halt 422, body
    end
  end
end
