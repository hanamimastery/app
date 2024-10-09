# frozen_string_literal: true

require 'dry/transformer'
module Main
  module Repos
    class Episodes < DB::Repo[:episodes]
      commands :create, delete: :by_pk

      TRANSFORMATION = Transformations::FrontMatterToDB.new

      # Transforms episode front_matter merged with github_file object hash
      #   into the input interpretable by episodes relation
      # @example
      #  repo.episodes.changeset(GithubEpisodeChangeset, array_of_tuples)
      #
      class CreateEpisodeChangeset < ROM::Changeset::Create[:episodes]
        command_options result: :many

        map do |tuple|
          TRANSFORMATION.call(tuple)
        end
      end

      # Transforms episode front_matter merged with github_file object hash
      #   into the input interpretable by episodes relation
      # @example
      #  repo.episodes.changeset(GithubEpisodeChangeset, array_of_tuples)
      #
      class UpdateEpisodeChangeset < ROM::Changeset::Update[:episodes]
        map do |tuple|
          TRANSFORMATION.call(tuple)
        end
      end

      def by_source_id(id)
        default_scope.where(source_id: id).one!
      end

      def recent
        default_scope.order { source_id.desc }.to_a
      end

      def source_paths
        default_scope.pluck(:source_path)
      end

      # allows to update record, passing down
      #  hash of direct DB fields, or data read from markdown file
      #  File fields will be transformed to the DB structure
      # @param [String] id of the record to update
      # @param [Hash] hash of attributes to update
      #
      def update(id, tuple)
        episodes.by_pk(id).changeset(UpdateEpisodeChangeset, tuple).commit
      end

      # allows to create one or many records, passing down
      #  hash of direct DB fields, or data read from markdown file
      #  File fields will be transformed to the DB structure
      # @param [Array or Hash] tuple or tuples with attributes to be saved
      #
      def create(tuples)
        episodes.changeset(CreateEpisodeChangeset, tuples).commit
      end
    end
  end
end
