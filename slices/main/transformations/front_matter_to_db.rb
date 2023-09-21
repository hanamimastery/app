# frozen_string_literal: true

module Main
  module Transformations
    # Given FrontMatter hash from Hanami Mastery Episode/Article File,
    #  Transforms keys to hash ready to be saved in DB.
    # Usage: FrontMatterToDB.new.call(hash)
    #
    class FrontMatterToDB < Dry::Transformer::Pipe
      import Dry::Transformer::HashTransformations

      define! do
        map_keys -> (k) { Dry::Inflector.new.underscore(k) }
        deep_symbolize_keys
        rename_keys(
          id: :source_id,
          path: :source_path,
          url: :source_url
        )
        accept_keys [
          :source_id,
          :excerpt,
          :modified_at,
          :published_at,
          :title,
          :topics,
          :video_id,
          :thumbnail,
          :discussions,
          :published,
          :source_path,
          :source_url,
          :content
        ]
      end
    end
  end
end
