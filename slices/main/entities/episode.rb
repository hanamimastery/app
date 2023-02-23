
# frozen_string_literal: true
require 'dry-transformer'

module Main
  module Entities
    class Episode < Entity
      class CoverTransformation < Dry::Transformer::Pipe
        import Dry::Transformer::HashTransformations

        define! do
          map_keys ->(v) { v.to_sym }
          map_values ->(v) { "https://hanamimastery.com/#{v}" }
        end
      end

      def cover
        CoverTransformation.new.call(thumbnail)
      end
    end
  end
end
