# frozen_string_literal: true

RSpec.describe Main::Interactors::RefreshEpisode do

  let(:github) { Mocks::Github::Client.new }
  let(:subject) { described_class.new(github: github) }

  let(:episode) do
    create(
      :episode,
      source_id: 2,
      source_path: 'fixtures/2-scheduled-episode.md',
      title: "Outdated Title",
      content: "## My outated episode content"
    )
  end

  describe '#call' do
    context 'when success' do
      it 'imports all the details from the new episode' do
        result = subject.call(episode.id)
        expect(result).to be_success
        refreshed = result.value![:episode]
        expect(refreshed.title).to eq('This is scheduled episode')
        expect(refreshed.content).to eq(
          <<~STRING
            This is the paragraph

            ## Scheduled for the future

            [Link](/link)
          STRING
        )
      end
    end

    context 'when cannot find episode' do
      let(:episode_id) { SecureRandom.uuid }

      it 'returns record not found' do
        result = subject.call(episode_id)
        expect(result).to be_failure
        expect(result.failure.code).to eq("HM0001")
        expect(result.failure.reason).to eq("Could not find record Main::Entities::Episode with primary key")
        expect(result.failure.metadata).to eq({ id: episode_id })
      end
    end

    context 'when reading github file content fails' do
      it 'it returns not found error' do
        error = Hanamimastery::Errors::GithubServiceError.new(
          'Github data fetching error',
          source_path: episode.source_path
        )
        allow(github).to receive(:fetch).and_raise(error)
        result = subject.call(episode.id)
        expect(result.failure.code).to eq("HM2100")
        expect(result.failure.reason).to eq("Github data fetching error")
        expect(result.failure.metadata).to eq({ source_path: episode.source_path })
      end
    end

    context 'when reading markdown fails fails', pending: true do
      it 'imports all the details from the new episode' do
        subject.call
      end
    end

    context 'when update fails', pending: true do
      it 'imports all the details from the new episode' do
        subject.call
      end
    end
  end
end
