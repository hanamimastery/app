# frozen_string_literal: true

require 'rom-factory'

module Test
  AppFactory = ROM::Factory.configure { |config| config.rom = Test::App::Database.rom }
  MainFactory = ROM::Factory.configure { |config| config.rom = Test::Main::Database.rom }
  module AppFactoryMethods
    def create(factory_name, **attrs)
      AppFactory[factory_name, **attrs]
    end

    def build(factory_name, attrs)
      AppFactory.structs[factory_name, **attrs]
    end
  end

  module MainFactoryMethods
    def create(factory_name, **attrs)
      MainFactory[factory_name, **attrs]
    end

    def build(factory_name, attrs)
      MainFactory.structs[factory_name, **attrs]
    end
  end
end

using Refinements::Pathnames
Pathname.require_tree SPEC_ROOT, 'support/factories/**/*.rb'

RSpec.configure do |config|
  config.include Test::AppFactoryMethods, :app_db
  config.include Test::MainFactoryMethods, :main_db
end
