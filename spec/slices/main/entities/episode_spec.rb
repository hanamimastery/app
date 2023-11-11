# frozen_string_literal: true

RSpec.describe Main::Entities::Episode do
  let(:params) { {} }
  let(:episode) { build(:episode, params) }

  describe '#version' do
    let(:params) { { source_url: 'git.repo/my/version_number' } }

    it 'returns blob version from the git URL' do
      expect(episode.version).to eq('version_number')
    end
  end

  describe '#cover' do
    it 'builds full URLs for cover images' do
      expect(episode.cover).to eq({
                                    full: "https://hanamimastery.com/images/episodes/#{episode.source_id}/cover-full.jpeg",
                                    big: "https://hanamimastery.com/images/episodes/#{episode.source_id}/cover-big.jpeg",
                                    small: "https://hanamimastery.com/images/episodes/#{episode.source_id}/cover-small.jpeg"
                                  })
    end
  end

  describe '#publication_url' do
    context 'when published' do
      let(:params) { { published: true } }

      it 'returns publication url' do
        expect(episode.publication_url).to eq("https://hanamimastery.com/episodes/#{episode.id}-episode")
      end
    end

    context 'when not published' do
      let(:params) { { published: false } }

      it 'returns publication url' do
        expect(episode.publication_url).to eq('')
      end
    end
  end

  describe '#status' do
    context 'when draft' do
      let(:params) { { published: false, published_at: nil } }

      it 'is draft' do
        aggregate_failures do
          expect(episode.status).to eq(described_class::STATUSES[:draft])
          expect(episode).to be_draft
          expect(episode).not_to be_scheduled
          expect(episode).not_to be_published
        end
      end
    end

    context 'when scheudled' do
      let(:params) { { published: false, published_at: '2022-08-09' } }

      it 'is scheduled' do
        aggregate_failures do
          expect(episode.status).to eq(described_class::STATUSES[:scheduled])
          expect(episode).not_to be_draft
          expect(episode).to be_scheduled
          expect(episode).not_to be_published
        end
      end
    end

    context 'when published' do
      let(:params) { { published: true, published_at: '2022-08-20' } }

      it 'is published' do
        aggregate_failures do
          expect(episode.status).to eq(described_class::STATUSES[:published])
          expect(episode).not_to be_draft
          expect(episode).not_to be_scheduled
          expect(episode).to be_published
        end
      end
    end
  end
end
