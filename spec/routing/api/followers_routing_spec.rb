require 'spec_helper'

describe 'routing to followers' do
  it 'routes /api/my/followers to api/followers#index' do
    expect(get: '/api/my/followers').to route_to(
      controller: 'api/followers',
      action: 'index'
    )
  end

  it 'routes /api/users/:id/followers to api/followers#index' do
    expect(get: '/api/users/10/followers').to route_to(
      controller: 'api/followers',
      action: 'index',
      user_id: '10'
    )
  end

end

