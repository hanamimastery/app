# frozen_string_literal: true

require 'rom-factory'

module Test
  Factory = ROM::Factory.configure { |config| config.rom = Test::Database.rom }
end
