require 'spec_helper'

describe 'routing to /api/users' do
  it 'routes /api/users to api/users#index' do
    expect(get: '/api/users').to route_to(
      controller: 'api/users',
      action: 'index'
    )
  end
end

