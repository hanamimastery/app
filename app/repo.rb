# auto_register: false
# frozen_string_literal: true

require 'rom-repository'

module Hanamimastery
  # The application repository.
  class Repo < ROM::Repository::Root
    include Deps[container: 'persistence.rom']

    auto_struct true

    commands :create, update: :by_pk

    def multi_insert(array)
      root.command(:create, result: :many).call(array)
    end

    def all
      root
    end

    def find(id)
      root.by_pk(id).one!
    end
  end
end
