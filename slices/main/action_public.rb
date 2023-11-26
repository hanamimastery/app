# auto_register: false
# frozen_string_literal: true

module Main
  # The main action.
  class ActionPublic < Hanamimastery::Action
    include Hanamimastery::Utils::Pagination
  end
end
