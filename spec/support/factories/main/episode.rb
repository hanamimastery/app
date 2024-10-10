# frozen_string_literal: true

Test::MainFactory.define(:episode, struct_namespace: Main::Structs) do |f|
  f.sequence(:source_id) { |n| n }
  f.source_url { |source_id| "https://api.github.com/repos/swilgosz/hanamimastery/git/blobs/#{source_id}" }
  f.source_path { |source_id| "data/episodes/#{source_id}-episode" }
  # f.author "swilgosz"
  f.topics ['hanami']
  f.title 'This is sample episode'
  f.published false
  f.published_at nil
  f.modified_at '2022-02-06'
  # f.aliases ['HMEP001']
  f.video_id 'Gx4eqU-oDL8'
  f.thumbnail do |source_id|
    {
      full: "images/episodes/#{source_id}/cover-full.jpeg",
      big: "images/episodes/#{source_id}/cover-big.jpeg",
      small: "images/episodes/#{source_id}/cover-small.jpeg"
    }
  end
  f.discussions do |source_id|
    {
      twitter: "https://twitter.com/HanamiMastery/status/#{source_id}",
      reddit: {
        ruby: "https://www.reddit.com/r/ruby/comments/o28dun/#{source_id}"
      }
    }
  end
  # f.source {|n| "https://github.com/hanamimastery/episodes/tree/main/#{ format('%03d', n) }" }
  # f.  timestamps
end
