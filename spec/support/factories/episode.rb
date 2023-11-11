# frozen_string_literal: true

Test::Factory.define(:episode, struct_namespace: Main::Entities) do |f|
  f.sequence(:source_id) { |n| n }
  f.sequence(:source_url) { |n| "https://api.github.com/repos/swilgosz/hanamimastery/git/blobs/#{n}" }
  f.sequence(:source_path) { |n| "data/episodes/#{n}-episode" }
  # f.author "swilgosz"
  f.topics ['hanami']
  f.title 'This is sample episode'
  f.published false
  f.published_at nil
  f.modified_at '2022-02-06'
  # f.aliases ['HMEP001']
  f.video_id 'Gx4eqU-oDL8'
  f.sequence(:thumbnail) do |n|
    {
      full: "images/episodes/#{n}/cover-full.jpeg",
      big: "images/episodes/#{n}/cover-big.jpeg",
      small: "images/episodes/#{n}/cover-small.jpeg"
    }
  end
  f.sequence(:discussions) do |n|
    {
      twitter: "https://twitter.com/HanamiMastery/status/#{n}",
      reddit: {
        ruby: "https://www.reddit.com/r/ruby/comments/o28dun/#{n}"
      }
    }
  end
  # f.source {|n| "https://github.com/hanamimastery/episodes/tree/main/#{ format('%03d', n) }" }
  # f.  timestamps
end
