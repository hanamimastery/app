# frozen_string_literal: true

require 'dry/transformer'
module Main
  module Repos
    class Accounts < Main::DB::Repo[:accounts]
      # commands :create, delete: :by_pk

      def by_nickname(nickname)
        default_scope.where(nickname: nickname).one
      end
    end
  end
end
