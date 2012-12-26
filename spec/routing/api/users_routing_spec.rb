require 'spec_helper'

describe 'routing to /api/users' do
  it 'routes /api/users to api/users#index' do
    expect(get: '/api/users').to route_to(
      controller: 'api/users',
      action: 'index'
    )
  end
  it 'routes /api/users/:id to api/users#show' do
    expect(get: '/api/users/10').to route_to(
      controller: 'api/users',
      action: 'show',
      id: '10'
    )
  end
end

