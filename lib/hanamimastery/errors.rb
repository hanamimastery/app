# frozen_string_literal: true

module Hanamimastery
  module Errors
    class Error < StandardError
      attr_reader :reason, :severity, :metadata

      SEVERITY = {
        0 => :no_action,
        1 => :low,
        2 => :medium,
        3 => :urgent
      }

      def self.code(code_string)
        define_method(:code) { code_string }
      end

      # Falling back to urgent, as it means, something unexpected happens,
      #   not forseen by developers, potentially crashing the system.
      #
      def self.severity(severity_symbol)
        level = SEVERITY.key(severity_symbol) || SEVERITY.key(:urgent)
        define_method(:default_severity_level) { level }
      end

      def initialize(reason, **details)
        @reason = reason
        @code = code
        @severity = severity_level(details.delete(:severity))
        @metadata = details
        super(default_message)
      end


      def to_h
        {
          reason: reason,
          code: code,
          severity: severity,
          metadata: metadata
        }
      end

      def to_json(*)
        to_h.to_json
      end

      private

      def default_message
        severity_string = "SEV#{severity}"
        [
          severity_string,
          code,
          reason,
          metadata&.to_json
        ].join(': ')
      end

      def severity_level(severity_symbol)
        SEVERITY.key(severity_symbol) || default_severity_level
      end
    end

    # Indicates that input data is incorrect
    #
    class InputDataError < Error
      code 'HM0000'
      severity :low
    end


    # Indicates that input data is incorrect
    #
    class RecordNotFound < InputDataError
      code 'HM0001'
      severity :low
    end

    # Indicates that input data is incorrect
    #
    class InternalError < Error
      code 'HM1000'
      severity :medium
    end

    # Indicates that error comes from external service, like Github, Google or Notion
    #
    class ExternalError < Error
      code 'HM2000'
      severity :medium
    end

    class GithubServiceError < ExternalError
      code 'HM2100'
      severity :medium
    end
  end
end
