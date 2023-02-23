# frozen_string_literal: true

Hanami.app.register_provider :parsers, namespace: true do
  prepare do
    require 'front_matter_parser'

    parser = FrontMatterParser::Parser.new(:md)
    register 'front_matter', parser
  end
end
