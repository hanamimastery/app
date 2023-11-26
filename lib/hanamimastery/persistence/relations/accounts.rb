# frozen_string_literal: true

module Hanamimastery
  module Persistence
    module Relations
      class Accounts < ROM::Relation[:sql]
        schema(:accounts, infer: true)
      end
    end
  end
end
