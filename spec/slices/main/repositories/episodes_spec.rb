# frozen_string_literal: true

RSpec.describe Main::Repositories::Episodes do
  let(:tuples) do
    [
      {
        id: 1,
        url: 'https://api.github.com/repos/swilgosz/hanamimastery/git/blobs/b7beb55796cb9586b05b944a3a2adab5f3e3aa84',
        path: 'fixtures/1-draft-episode',
        author: "swilgosz",
        topics: ["hanami"],
        title: "This is draft episode",
        published: false,
        published_at: nil,
        modified_at: "2022-02-06",
        aliases: ['HMEP001'],
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
        },
        source: "https://github.com/hanamimastery/episodes/tree/main/001"
      },
      {
        id: 3,
        url: 'https://api.github.com/repos/swilgosz/hanamimastery/git/blobs/b7beb55796cb9586b05b944a3a2adab5f3e3aa84',
        path: 'fixtures/3-published-episode',
        author: "swilgosz",
        topics: ["hanami"],
        title: "This is published episode",
        published: true,
        published_at: "2023-09-01",
        modified_at: "2022-02-06",
        aliases: ['HMEP002'],
        video_id: "Gx4eqU-oDL8",
        thumbnail: {
          full: "images/episodes/3/cover-full.jpeg",
          big: "images/episodes/3/cover-big.jpeg",
          small: "images/episodes/3/cover-small.jpeg"
        },
        discussions: {
          twitter: "https://twitter.com/HanamiMastery/status/3",
          reddit: {
            ruby: "https://www.reddit.com/r/ruby/comments/o28dun/3",
          }
        },
        source: "https://github.com/hanamimastery/episodes/tree/main/003"
      }
    ]
  end

  describe "#create" do
    it 'creates multiple records with correct transformation' do
      expect{ subject.create(tuples) }.to change { subject.episodes.count }.by(2)
      episode = subject.by_source_id(1)

      aggregate_failures do
        expect(episode.source_url).to eq('https://api.github.com/repos/swilgosz/hanamimastery/git/blobs/b7beb55796cb9586b05b944a3a2adab5f3e3aa84')
        expect(episode.source_path).to eq('fixtures/1-draft-episode')
        expect(episode.published).to eq(false)
        expect(episode.cover).to eq(
          {
            full: "https://hanamimastery.com/images/episodes/1/cover-full.jpeg",
            big: "https://hanamimastery.com/images/episodes/1/cover-big.jpeg",
            small: "https://hanamimastery.com/images/episodes/1/cover-small.jpeg"
          }
        )
        expect(episode.publication_url).to eq('')
      end
    end

    it 'creates single record' do
      expect { subject.create(tuples[1]) }.to change { subject.episodes.count }.by(1)
      episode = subject.by_source_id(3)
      expect(episode.publication_url).to eq('https://hanamimastery.com/episodes/3-published-episode')
    end
  end

  describe "#update" do
    it 'updates record' do
      subject.create(tuples[1])
      episode = subject.by_source_id(3)
      expect(subject.update(episode.id, title: 'updated title'))

      episode = subject.by_source_id(3)
      expect(episode.title).to eq('updated title')
    end
  end

  describe "#recent" do
    before { subject.create(tuples) }

    it 'returns records in proper order' do
      expect(subject.recent.map(&:source_id)).to eq([3, 1])
    end
  end

  describe "source_paths" do
    before { subject.create(tuples) }

    it 'returns records in proper order' do
      expect(subject.source_paths).to contain_exactly(
        *tuples.map { |i| i[:path] }
      )
    end
  end
end
