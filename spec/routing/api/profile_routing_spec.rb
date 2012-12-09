require 'spec_helper'

describe 'routing to profile' do
  it 'routes /api/profile to api/profile#index' do
    expect(get: '/api/profile').to route_to(
      controller: 'api/profile',
      action: 'index'
    )
  end

  it 'routes /api/profile/:id to api/profile#show' do
    expect(get: '/api/profile/20').to route_to(
      controller: 'api/profile',
      action: 'show',
      id: '20'
    )
  end

end

