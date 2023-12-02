# frozen_string_literal: true

RSpec.describe 'Main::Slice::Routes' do
  let(:router) { Main::Slice.router }

  it 'recognizes "GET /episodes"' do
    route = router.recognize(:episodes)
    aggregate_failures do
      expect(route).to be_routable
      expect(route.path).to eq('/episodes')
      expect(route.verb).to eq('GET')
      expect(route.params).to eq({})
    end
  end

  it 'recognizes "POST /episodes/fetch"' do
    route = router.recognize(:fetch_episodes, {}, method: :post)
    aggregate_failures do
      expect(route).to be_routable
      expect(route.path).to eq('/episodes/fetch')
      expect(route.verb).to eq('POST')
    end
  end

  it 'recognizes "GET /episodes/1"' do
    route = router.recognize(:episode, { id: 1 }, method: :get)
    aggregate_failures do
      expect(route).to be_routable
      expect(route.path).to eq('/episodes/1')
      expect(route.verb).to eq('GET')
      # expect(route.params).to eq({ id: '1' })
    end
  end

  it 'recognizes "GET /episodes/1/:view"' do
    route = router.recognize(:episode_view, { id: 1, view: 'hashnode' }, method: :get)
    aggregate_failures do
      expect(route).to be_routable
      expect(route.path).to eq('/episodes/1/hashnode')
      expect(route.verb).to eq('GET')
      expect(route.params).to eq({ id: '1', view: 'hashnode' })
    end
  end

  it 'recognizes "PATCH /episodes/1/refresh"' do
    route = router.recognize(:refresh_episode, { id: 1 }, method: :patch)
    aggregate_failures do
      expect(route).to be_routable
      expect(route.path).to eq('/episodes/1/refresh')
      expect(route.verb).to eq('PATCH')
      expect(route.params).to eq({ id: '1' })
    end
  end
end
