# frozen_string_literal: true

require 'capybara/cuprite'
require 'capybara/rspec'

Capybara.app = Hanami.app
Capybara.server = :puma, { Silent: true }
Capybara.javascript_driver = :cuprite
Capybara.save_path = Hanami.app.root.join 'tmp/capybara'
Capybara.register_driver :cuprite do |app|
  Capybara::Cuprite::Driver.new app, window_size: [1200, 800]
end

RSpec.configure do |config|
  config.include Capybara::DSL, Capybara::RSpecMatchers, :web
end
