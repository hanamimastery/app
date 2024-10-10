# frozen_string_literal: true

require "hanami/db/repo"

module Hanamimastery
  module DB
    class Repo < Hanami::DB::Repo
      include Hanamimastery::Utils::Pagination::Reader

      auto_struct true

      commands :create, delete: :by_pk

      def multi_insert(array)
        root.command(:create, result: :many).call(array)
      end

      def all
        default_scope.to_a
      end

      def find(id)
        root.by_pk(id).one!
      rescue PG::UndefinedFunction, PG::InvalidTextRepresentation, ROM::TupleCountMismatchError
        raise Errors::RecordNotFound.new(
          "Could not find record #{root.mapper.model} with primary key",
          id:
        )
      end

      private

      def default_scope
        root
          .per_page(pagination.size)
          .page(pagination.number)
      rescue Hanamimastery::Utils::Pagination::PaginationUnsetError
        root
      end
    end
  end
end
