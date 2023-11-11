# frozen_string_literal: true

RSpec.describe 'Main::Slice::Routes' do
  let(:router) { Main::Slice.router }

  it 'recognizes "GET /"' do
    expect(router.path(:root)).to eq('/')

    route = router.recognize('/')
    aggregate_failures do
      expect(route).to be_routable
      expect(route.path).to eq('/')
      expect(route.verb).to eq('GET')
    end
  end

  it 'recognizes "GET /episodes"' do
    route = router.recognize('/episodes')
    aggregate_failures do
      expect(route).to be_routable
      expect(route.path).to eq('/episodes')
      expect(route.verb).to eq('GET')
      expect(route.params).to eq({})
    end
  end

  it 'recognizes "POST /episodes/fetch"' do
    route = router.recognize('/episodes/fetch', {}, method: :post)
    aggregate_failures do
      expect(route).to be_routable
      expect(route.path).to eq('/episodes/fetch')
      expect(route.verb).to eq('POST')
    end
  end

  it 'recognizes "PATCH /episodes/1/refresh"' do
    route = router.recognize('/episodes/1/refresh', {}, method: :patch)
    aggregate_failures do
      expect(route).to be_routable
      expect(route.path).to eq('/episodes/1/refresh')
      expect(route.verb).to eq('PATCH')
      expect(route.params).to eq({ id: '1' })
    end
  end
end
