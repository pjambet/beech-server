require 'spec_helper'

describe 'routing to feed' do
  it 'routes /api/my/feed to feed#index' do
    expect(get: '/api/my/feed').to route_to(
      controller: 'api/feed',
      action: 'index'
    )
  end

  it 'routes /api/users/:user_id/feed to feed#index' do
    expect(get: '/api/users/10/feed').to route_to(
      controller: 'api/feed',
      action: 'index',
      user_id: '10'
    )
  end

end

