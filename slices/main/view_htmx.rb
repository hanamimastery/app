# auto_register: false
# frozen_string_literal: true

module Main
  # The main HTMX view, with additional configuration, like skipping the layout.
  class ViewHTMX < Hanamimastery::View
    config.layout = false
    config.paths = [Pathname(__dir__).join('templates').expand_path]
  end
end
