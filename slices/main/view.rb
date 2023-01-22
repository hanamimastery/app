# auto_register: false
# frozen_string_literal: true

module Main
  # The main view.
  class View < Hanamimastery::View
    config.paths = [Pathname(__dir__).join("templates").expand_path]
  end
end
