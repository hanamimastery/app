# frozen_string_literal: true

require 'dry/transformer'
module T
  extend Dry::Transformer::Registry

  import :deep_symbolize_keys, from: Dry::Transformer::HashTransformations
  import :reject_keys, from: Dry::Transformer::HashTransformations
end

module Main
  module Repositories
    class Episodes < Repo[:episodes]
      # Transforms episode front_matter merged with github_file object hash
      #   into the input interpretable by episodes relation
      # @example
      #  repo.episodes.changeset(GithubEpisodeChangeset, array_of_tuples)
      #
      class GithubEpisodeChangeset < ROM::Changeset::Create[:episodes]
        command_options result: :many

        map do |tuple|
          transformed = T[:reject_keys].call(T[:deep_symbolize_keys].call(tuple), [:id]).
            transform_keys do |key|
              case key
              when :path then :source_path
              when :url then :source_url
              else
                key
              end
            end
          transformed.merge(source_id: transformed[:source_path].split('/').last.split(/-/).first.to_i)
        end
      end

      def recent
        episodes.order { source_id.desc }
      end

      def source_paths
        episodes.pluck(:source_path)
      end

      def create_from_github(tuples)
        episodes.changeset(GithubEpisodeChangeset, tuples).commit
      end
    end
  end
end
