# frozen_string_literal: true

module Main
  module Repositories
    class Episodes < Repo[:episodes]
      def recent
        episodes.order { source_id.desc }
      end
    end
  end
end
