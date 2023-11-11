# frozen_string_literal: true

require 'rom-factory'

module Test
  Factory = ROM::Factory.configure { |config| config.rom = Test::Database.rom }
  module FactoryMethods
    def create(factory_name, **attrs)
      Factory[factory_name, **attrs]
    end

    def build(factory_name, attrs)
      Factory.structs[factory_name, **attrs]
    end
  end
end

using Refinements::Pathnames
Pathname.require_tree SPEC_ROOT, 'support/factories/**/*.rb'

RSpec.configure do |config|
  config.include Test::FactoryMethods
end
