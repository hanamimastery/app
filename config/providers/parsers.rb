# frozen_string_literal: true

Hanami.app.register_provider :parsers, namespace: true do
  prepare do
    require 'front_matter_parser'

    loader = FrontMatterParser::Loader::Yaml.new(allowlist_classes: [Date])
    parser = FrontMatterParser::Parser.new(:md, loader: loader)
    register 'front_matter', parser
  end
end
