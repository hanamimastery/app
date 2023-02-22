# frozen_string_literal: true

module Main
  module Transformations
    # Given FrontMatter hash from Hanami Mastery Episode/Article File,
    #  Transforms keys to hash ready to be saved in DB.
    #
    class FrontMatterToDB < Dry::Transformer::Pipe
      import Dry::Transformer::HashTransformations

      define! do
        map_keys -> (k) { Dry::Inflector.new.underscore(k) }
        deep_symbolize_keys
        accept_keys [:topics, :title, :excerpt, :video_id, :published_at, :modified_at, :thumbnail, :discussions]
      end
    end
  end
end
