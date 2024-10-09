# frozen_string_literal: true

require 'front_matter_parser'

module Main
  module Interactors
    # Fetches new data for an episode, then updates the local version of it.
    #   TODO: Change it later to just publish a draft crated event.
    #
    class RefreshEpisode < Main::Interactor
      include Deps[
        'integrations.github',
        'parsers.front_matter',
        'repos.episodes',
        transformation: 'transformations.front_matter_to_db'
      ]

      def call(id)
        episode = yield find_episode(id)
        content = yield fetch_updated_content(episode.source_path)
        parsed = yield read_markdown(content)
        updated = yield update_episode(id, parsed)

        Success(episode: updated)
      rescue StandardError => e
        Failure(e)
      end

      private

      def find_episode(id)
        Success(episodes.find(id))
      end

      # Get new episode data from github.
      #
      def fetch_updated_content(path)
        Success(github.fetch(path))
      end

      # Transforms the MD file content to the structure ready to be saved in DB
      #   TODO: Think how to use FronMatterToDB transformation, and the other way around.
      # @param [String] Markdown file content, including frontmatter of the episode.
      #   This is a source file content pulled from github repository.
      # @return [Hash] Attriutes hash ready to be saved/updated in the DB
      #
      def read_markdown(content)
        parsed = front_matter.call(content)
        Success(parsed.front_matter.merge(content: parsed.content))
      end

      def update_episode(id, parsed)
        Success(episodes.update(id, parsed))
      end
    end
  end
end
