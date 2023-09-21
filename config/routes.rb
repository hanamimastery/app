# frozen_string_literal: true

module Hanamimastery
  # Configures application routes.
  class Routes < Hanami::Routes
    slice :main, at: '/'
  end
end
