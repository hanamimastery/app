# frozen_string_literal: true

RSpec.describe 'Main::Slice::Routes#registrations' do
  let(:router) { Main::Slice.router }

  it 'recognizes "GET /signup"' do
    route = router.recognize(:signup, {}, method: :get)
    aggregate_failures do
      expect(route).to be_routable
      expect(route.path).to eq('/signup')
      # expect(route.endpoint).to eq('registrations.new')
      expect(route.verb).to eq('GET')
    end
  end

  it 'recognizes "POST /signup"' do
    route = router.recognize(:register_account, {}, method: :post)
    aggregate_failures do
      expect(route).to be_routable
      expect(route.path).to eq('/signup')
      # expect(route.endpoint).to eq('registrations.create')
      expect(route.verb).to eq('POST')
    end
  end
end
