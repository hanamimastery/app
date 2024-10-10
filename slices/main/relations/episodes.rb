# frozen_string_literal: true

module Main
  module Relations
    class Episodes < Main::DB::Relation[:sql]
      schema(:episodes, infer: true) do
        # associations do
        #   belongs_to :authors, as: :author
        # end
      end
    end
  end
end
