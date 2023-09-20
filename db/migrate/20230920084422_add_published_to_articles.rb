# frozen_string_literal: true

ROM::SQL.migration do
  change do
    add_column :episodes, :published, :bool, default: false
  end
end
