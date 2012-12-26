require 'spec_helper'

describe 'routing to profile' do
  it 'routes /api/profiles/:id to api/profiles#show' do
    expect(get: '/api/profiles/20').to route_to(
      controller: 'api/profiles',
      action: 'show',
      id: '20'
    )
  end

end

