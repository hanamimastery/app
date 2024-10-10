# frozen_string_literal: true

ROM::SQL.migration do
  change do
    create_table :accounts do
      column :id, 'uuid', primary_key: true, default: Sequel.function(:uuid_generate_v4)
      column :nickname, String, unique: true
      column :encrypted_password, String
    end
  end
end
