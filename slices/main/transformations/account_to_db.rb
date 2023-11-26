# frozen_string_literal: true

require 'bcrypt'

module Main
  module Transformations
    # Given Parameters hash with password
    #   encrypts hash to be ready for saving in DB.
    # Usage: AccountToDB.new.call(hash)
    # @example
    #   hash = { nickname: 'jsmith', password: 'secret', 'password_confirmation' => 'secret' }
    #   AccountToDB.new.call(hash)
    #   # => { :nickname=>"jsmith", :encrypted_password=>"$2a$12$lwg0IK070j83lSKW/AsZQ.C/GfBLzsREd/5efZ.6hBNCEq.j0WooK" }
    #
    class AccountToDB < Dry::Transformer::Pipe
      import Dry::Transformer::HashTransformations

      define! do
        map_keys ->(k) { Dry::Inflector.new.underscore(k) }
        deep_symbolize_keys
        rename_keys(password: :encrypted_password)
        map_value(:encrypted_password, -> (v){ BCrypt::Password.create(v) })
        accept_keys(
          %i[
            encrypted_password
            nickname
          ]
        )
      end
    end
  end
end
