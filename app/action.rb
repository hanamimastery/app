# auto_register: false
# frozen_string_literal: true

require 'hanami/action'
require "dry/monads"

module Hanamimastery
  # The application action.
  class Action < Hanami::Action
    include Dry::Monads[:result]
  end
end
