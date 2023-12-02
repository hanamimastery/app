# frozen_string_literal: true

RSpec.describe 'Main::Slice::Routes' do
  let(:router) { Main::Slice.router }

  it 'recognizes "GET /"' do
    route = router.recognize(:root)
    aggregate_failures do
      expect(route).to be_routable
      expect(route.path).to eq('/')
      expect(route.verb).to eq('GET')
    end
  end
end
