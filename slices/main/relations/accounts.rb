# frozen_string_literal: true

module Main
  module Relations
    class Accounts < Main::DB::Relation[:sql]
      schema(:accounts, infer: true)
    end
  end
end
