# frozen_string_literal: true

RSpec.describe 'Root', type: :request do
  it 'is successful' do
    get '/'

    # Find me in `config/routes.rb`
    expect(last_response).to be_successful
    expect(last_response.body).to include('<h1>Welcome to HanamiMastery!</h1>')
  end
end
