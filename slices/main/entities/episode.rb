
# frozen_string_literal: true
require 'dry-transformer'

module Main
  module Entities
    class Episode < Entity
      DOMAIN = "https://hanamimastery.com"

      STATUSES = {
        draft: 0,
        scheduled: 1,
        published: 2
      }

      class CoverTransformation < Dry::Transformer::Pipe
        import Dry::Transformer::HashTransformations

        define! do
          map_keys ->(v) { v.to_sym }
          map_values ->(v) { "#{DOMAIN}/#{v}" }
        end
      end

      # Provides a hash of thumbnail URLs with host included
      # @return [Hash]
      #
      def cover
        CoverTransformation.new.call(thumbnail)
      end

      # The URL you can visit to get the published version of the article
      #
      def publication_url
        return "" unless published?

        [DOMAIN, 'episodes', source_path.split('/').last].join('/')
      end

      # Returns github version of the episode content
      #   Useful to quickly evaluate if we need to fetch new data
      #
      def version
        source_url.split('/').last
      end

      # Determines if the episode is published or not
      # @return [Boolean]
      #
      def published?
        published == true
      end

      # Determines if the episode is scheduled
      # @return [Boolean]
      #
      def scheduled?
        status == STATUSES[:scheduled]
      end

      # Determines if the episode is WIP
      # @return [Boolean]
      #
      def draft?
        status == STATUSES[:draft]
      end

      # Figures out the status of the episode based on it's attributes
      #
      def status
        return STATUSES[:published] if published?
        return STATUSES[:scheduled] if published_at

        STATUSES[:draft]
      end
    end
  end
end
