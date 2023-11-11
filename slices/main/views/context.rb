# frozen_string_literal: true

module Main
  module Views
    class Context < Hanami::View::Context
      include Deps["settings"]

      def font_awesome_kit
        settings.font_awesome_kit
      end
    end
  end
end
