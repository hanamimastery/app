# frozen_string_literal: true

ROM::SQL.migration do
  change do
    execute 'CREATE EXTENSION IF NOT EXISTS "uuid-ossp"'

    create_table :episodes do
      column :id, 'uuid', primary_key: true, default: Sequel.function(:uuid_generate_v4)
      column :source_id, Integer
      column :source_path, String
      column :source_url, String
      column :sha, String

      column :type, String

      column :topics, 'text[]'
      column :title, String
      column :excerpt, String
      column :video_id, String
      column :published_at, DateTime
      column :modified_at, DateTime
      column :thumbnail, 'jsonb', null: false, default: '{}'
      column :discussions, 'jsonb', null: false, default: '{}'

      column :content, String
    end
  end
end
