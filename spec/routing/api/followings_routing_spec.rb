require 'spec_helper'

describe 'routing to followings' do
  it 'routes /api/followings to api/followings#index' do
    expect(get: '/api/followings').to route_to(
      controller: 'api/followings',
      action: 'index'
    )
  end

  it 'routes /api/followings to api/followings#create' do
    expect(post: '/api/followings').to route_to(
      controller: 'api/followings',
      action: 'create'
    )
  end

  it 'routes /api/followings/ to api/followings#destroy' do
    expect(delete: '/api/followings').to route_to(
      controller: 'api/followings',
      action: 'destroy',
    )
  end

end

