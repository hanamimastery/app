# frozen_string_literal: true

require 'dry/transformer'
module Main
  module Repositories
    class Episodes < Repo[:episodes]
      commands :create, update: :by_pk, delete: :by_pk

      TRANSFORMATION = Transformations::FrontMatterToDB.new

      # Transforms episode front_matter merged with github_file object hash
      #   into the input interpretable by episodes relation
      # @example
      #  repo.episodes.changeset(GithubEpisodeChangeset, array_of_tuples)
      #
      class GithubEpisodeChangeset < ROM::Changeset::Create[:episodes]
        command_options result: :many

        extend Deps[transformation: 'transformations.front_matter_to_db']

        map do |tuple|
          TRANSFORMATION.call(tuple)
        end
      end

      def by_source_id(id)
        episodes.where(source_id: id).one!
      end

      def recent
        episodes.order { source_id.desc }.to_a
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
