# frozen_string_literal: true

module Main
  module Views
    module Parts
      module Forms
        class Session < Part
          def nickname_input(f)
            scope(
              Scopes::Forms::Input,
              f: f,
              field_name: :nickname,
              errors: errors(:nickname)
            ).render("shared/forms/text_field")
          end

          def password_input(f)
            scope(
              Scopes::Forms::Input,
              f: f,
              field_name: :password,
              errors: errors(:password),
            ).render("shared/forms/password_field")
          end

          def errors(key)
            value.dig(:errors, key).to_a
          end
        end
      end
    end
  end
end
