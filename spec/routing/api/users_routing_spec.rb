require 'spec_helper'

describe 'routing to /api/users' do
  it 'routes /api/users/search to api/users#search' do
    expect(get: '/api/users/search').to route_to(
      controller: 'api/users',
      action: 'search'
    )
  end
end

