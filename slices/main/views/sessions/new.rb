# frozen_string_literal: true

module Main
  module Views
    module Sessions
      class New < Main::View
        expose(:form, as: Parts::Forms::Session) do |model: {}, errors: {}|
          {
            values: model,
            errors: errors
          }
        end
      end
    end
  end
end
