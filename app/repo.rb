# auto_register: false
# frozen_string_literal: true

require "rom-repository"

module Hanamimastery
  # The application repository.
  class Repo < ROM::Repository::Root
    include Deps[container: "persistence.rom"]
  end
end
