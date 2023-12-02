# frozen_string_literal: true

RSpec.describe 'Main::Slice::Routes' do
  let(:router) { Main::Slice.router }

  it 'recognizes "GET /login"' do
    route = router.recognize(:login, {}, method: :get)
    aggregate_failures do
      expect(route).to be_routable
      expect(route.path).to eq('/login')
      # expect(route.endpoint).to eq('sessions.new')
      expect(route.verb).to eq('GET')
    end
  end

  it 'recognizes "POST /signup"' do
    route = router.recognize(:authenticate, {}, method: :post)
    aggregate_failures do
      expect(route).to be_routable
      expect(route.path).to eq('/login')
      # expect(route.endpoint).to eq('sessions.create')
      expect(route.verb).to eq('POST')
    end
  end
end
