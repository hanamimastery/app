# frozen_string_literal: true

require 'front_matter_parser'

module Main
  module Interactors
    # Fetches new draft episodes from Github and saves them in databse.
    #   TODO: Change it later to just publish a draft crated event.
    #
    class FetchDraftEpisodes < Main::Interactor
      include Deps[
        'integrations.github',
        'parsers.front_matter',
        'repos.episodes',
        transformation: 'transformations.front_matter_to_db'
      ]

      def call
        tuples = fetch_new_github_entries.map do |entry|
          content = github.fetch(entry.path)
          parsed = front_matter.call(content)
          entry.to_h.merge(content: parsed.content, **parsed.front_matter)
        end
        new_drafts = episodes.create(tuples)
        Success(drafts: new_drafts)
      end

      private

      def fetch_new_github_entries
        entries = github.entries
        new_paths = entries.map(&:path) - episodes.source_paths
        entries.select { |entry| new_paths.include?(entry.path) }
      end
    end
  end
end
