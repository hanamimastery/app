# frozen_string_literal: true

module Main
  module Views
    class Context < Hanami::View::Context
      include Deps[
        "settings",
        "repos.accounts"
      ]
      private :settings, :accounts

      def font_awesome_kit
        settings.font_awesome_kit
      end

      def current_user
        return unless id = session[:current_user_id]

        accounts.find(id)
      end
    end
  end
end
