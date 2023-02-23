# frozen_string_literal: true

module Hanamimastery
  module Persistence
    module Relations
      class Episodes < ROM::Relation[:sql]
        schema(:episodes, infer: true) do
          # associations do
          #   belongs_to :authors, as: :author
          # end
        end
      end
    end
  end
end
