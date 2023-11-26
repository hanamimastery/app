# frozen_string_literal: true

module Main
  module Views
    module Scopes
      module Forms
        class Input < Main::Views::Scope
          def field_name
            super.to_s
          end

          def control_field_classes
            classes = %w[control has-icons-left]
            classes << 'has-icons-right' if error_field?
            classes.join(' ')
          end

          def label_text
            return label if respond_to?(:label) && label

            _context.inflector.humanize(field_name)
          end

          def placeholder_text
            return placeholder if respond_to?(:placeholder) && placeholder

            _context.inflector.humanize(field_name)
          end

          def input_field_classes
            classes = %w[input]
            classes << "is-danger" if error_field?
            classes.join(' ')
          end

          def error_field?
            errors.any?
          end
        end
      end
    end
  end
end
