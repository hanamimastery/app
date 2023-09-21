# frozen_string_literal: true

RSpec.describe Main::Transformations::FrontMatterToDB do
  describe "#call" do
    context 'when full hash provided' do
      let(:input) do
        {
          # Fields coming from github entry API
          "url" => 'https://api.github.com/repos/swilgosz/hanamimastery/git/blobs/b7beb55796cb9586b05b944a3a2adab5f3e3aa84',
          "path" => 'fixtures/1-draft-episode',


          # Fields from the markdown file
          "id" => 1,
          "author" => "swilgosz",
          "topics" => ["hanami"],
          "title" => "This is draft episode",
          "published" => false,
          "publishedAt" => nil,
          "modifiedAt" => "2022-02-06",
          "aliases" => ['HMEP001'],
          "videoId" => "Gx4eqU-oDL8",
          "thumbnail" => {
            "full" => "images/episodes/1/cover-full.jpeg",
            "big" => "images/episodes/1/cover-big.jpeg",
            "small" => "images/episodes/1/cover-small.jpeg"
          },
          "discussions" => {
            "twitter" => "https://twitter.com/HanamiMastery/status/1",
            "reddit" => {
              "ruby" => "https://www.reddit.com/r/ruby/comments/o28dun/1",
            }
          },
          "source" => "https://github.com/hanamimastery/episodes/tree/main/001"
        }
      end

      it 'transforms input properly' do
        response = subject.call(input)
        expect(response).to eq(
          {
            # Fields coming from github entry API
            source_url: 'https://api.github.com/repos/swilgosz/hanamimastery/git/blobs/b7beb55796cb9586b05b944a3a2adab5f3e3aa84',
            source_path: 'fixtures/1-draft-episode',

            # Fields from the markdown file
            source_id: 1,
            topics: ["hanami"],
            title: "This is draft episode",
            published: false,
            published_at: nil,
            modified_at: "2022-02-06",
            video_id: "Gx4eqU-oDL8",
            thumbnail: {
              full: "images/episodes/1/cover-full.jpeg",
              big: "images/episodes/1/cover-big.jpeg",
              small: "images/episodes/1/cover-small.jpeg"
            },
            discussions: {
              twitter: "https://twitter.com/HanamiMastery/status/1",
              reddit: {
                ruby: "https://www.reddit.com/r/ruby/comments/o28dun/1",
              }
            }
          }
        )
      end
    end

    context 'when subhash provided' do
      let(:input) { { 'title' => 'New title' } }

      it 'returns transformed subhash' do
        response = subject.call(input)
        expect(response).to eq(
          { title: 'New title' }
        )
      end
    end

    context 'when already renamed keys provided' do
      let(:input) { { 'source_id' => 4 } }

      it 'returns transformed subhash' do
        response = subject.call(input)
        expect(response).to eq(
          { source_id: 4 }
        )
      end
    end
  end
end
