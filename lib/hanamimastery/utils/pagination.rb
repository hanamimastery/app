# frozen_string_literal: true

require 'dry-effects'

module Hanamimastery
  module Utils
    # Allows to paginate resources based on input parameters
    #
    module Pagination
      PaginationParamsError = Class.new(StandardError)
      PaginationUnsetError = Class.new(StandardError)

      module Reader
        def self.included(klass)
          klass.include Dry::Effects.Reader(:pagination)
          klass.define_method(:pagination) do
            super()
          rescue Dry::Effects::Errors::MissingStateError
            raise PaginationUnsetError, "You're trying to access pagination without setting it up."
          end
        end
      end

      class PaginationPage < Dry::Struct
        attribute :number, Types::Integer
        attribute :size, Types::Integer
      end

      def self.included(klass)
        klass.include Dry::Effects::Handler.Reader(:pagination)
      end

      DEFAULT_PAGE = 1
      DEFAULT_SIZE = 10

      # Ensures page parameters are of correct type
      #   or that values are coercible to defaults
      #
      PaginationType =
        Types::Hash.schema(
          page: Types::Hash.schema(
            size: Types::Coercible::Integer.
                    default(DEFAULT_SIZE).
                    constructor { |value|
                      value.nil? ? Dry::Types::Undefined : value
                    }.constrained(gteq: 1, lteq: 50),
            number: Types::Coercible::Integer.
                    default(DEFAULT_PAGE).
                    constructor { |value|
                      value.nil? ? Dry::Types::Undefined : value
                    }.constrained(gteq: 1)
                ).with_key_transform(&:to_sym)
        ).
        with_key_transform(&:to_sym).
        constructor { |value|
          (value.nil? || value.to_h.empty?) ? { page: {} } : value
        }

      # Sets the pagination object and throws it down the stack,
      #   Yields the block making pagination object accessible within
      # @param [Hash] pagination parameters
      # @example
      #   include Hanamimastery::Utiles::Pagination
      #   def handle(request, response)
      #     paginate(request.params) { render view }
      #   end
      #
      def paginate(params_hash = {}, &block)
        with_pagination(detect_page(params_hash)) do
          block.call if block_given?
        end
      end

      # @api_private
      # Based on the input hash, validate the schema and initialize hte PaginationPage object
      # @param [Hash]
      # @return [PaginationPage] a pagination page object with default values set
      #
      def detect_page(params_hash)
        page_params = PaginationType[params_hash.to_h]
        PaginationPage.new(page_params[:page])

      rescue Dry::Types::SchemaError => e
        raise PaginationParamsError, e.message
      end
    end
  end
end
