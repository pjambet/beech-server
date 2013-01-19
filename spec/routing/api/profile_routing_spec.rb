require 'spec_helper'

describe 'routing to profile' do
  it 'routes /api/my/profile to api/profiles#index' do
    expect(get: '/api/my/profile').to route_to(
      controller: 'api/profiles',
      action: 'show'
    )
  end

  it 'routes /api/users/10/profile to api/badges#index' do
    expect(get: '/api/users/10/profile').to route_to(
      controller: 'api/profiles',
      action: 'show',
      user_id: '10'
    )
  end

end

