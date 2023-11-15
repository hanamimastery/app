# frozen_string_literal: true

module Main
  module Views
    module Parts
      module Forms
        class Registration < Part
          def username_input(f)
            scope(
              Scopes::Shared::Forms::Input,
              f: f,
              field_name: :username,
              errors: errors(:username)
            ).render("shared/forms/text_field")
          end

          def password_input(f)
            scope(
              Scopes::Shared::Forms::Input,
              f: f,
              field_name: :password,
              errors: errors(:password),
            ).render("shared/forms/password_field")
          end

          def password_confirmation_input(f)
            scope(
              Scopes::Shared::Forms::Input,
              f: f,
              field_name: :password_confirmation,
              errors: errors(:password_confirmation),
            ).render("shared/forms/password_field")
          end

          def tac_input(f)
            tac_link = helpers.link_to "terms and conditions", "#"
            pp_link = helpers.link_to "privacy policy", "#"
            label_text = "I agree to the #{ tac_link } & #{ pp_link }".html_safe

            scope(
              Scopes::Shared::Forms::Input,
              f: f,
              field_name: :tac,
              label: label_text,
              errors: errors(:tac)
            ).render("shared/forms/check_box_field")
          end

          def errors(key)
            value.dig(:errors, key).to_a
          end
        end
      end
    end
  end
end
