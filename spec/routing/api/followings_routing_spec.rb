require 'spec_helper'

describe 'routing to followings' do
  it 'routes /api/my/followings to api/followings#index' do
    expect(get: '/api/my/followings').to route_to(
      controller: 'api/followings',
      action: 'index'
    )
  end

  it 'routes /api/my/followings to api/followings#create' do
    expect(post: '/api/my/followings').to route_to(
      controller: 'api/followings',
      action: 'create'
    )
  end

  it 'routes /api/my/followings/ to api/followings#destroy' do
    expect(delete: '/api/my/followings').to route_to(
      controller: 'api/followings',
      action: 'destroy',
    )
  end

  it 'routes /api/users/:id/followings to api/followings#index' do
    expect(get: '/api/users/10/followings').to route_to(
      controller: 'api/followings',
      action: 'index',
      user_id: '10'
    )
  end

end

