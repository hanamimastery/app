# frozen_string_literal: true

require 'dry/monads'
require 'dry/matcher/result_matcher'

module Main
  class Interactor
    def self.inherited(base)
      super
      base.include Dry::Monads[:do, :result]
      base.include Dry::Matcher.for(
        :call, with: Dry::Matcher::ResultMatcher
      )
    end
  end
end
