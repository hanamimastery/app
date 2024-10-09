# auto_register: false
# frozen_string_literal: true

require "dry/operation"

module Hanamimastery
  class Operation < Dry::Operation
    # Provide `transaction do ... end` method for database transactions
    include Dry::Operation::Extensions::ROM
  end
end
