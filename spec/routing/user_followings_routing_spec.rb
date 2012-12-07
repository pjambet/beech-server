require 'spec_helper'

describe 'routing to user followings' do
  it 'routes /users/:id/followings to followings#index' do
    expect(get: '/users/10/followings').to route_to(
      controller: 'followings',
      action: 'index',
      user_id: '10'
    )
  end

  it 'routes /users/:id/followings to followings#create' do
    expect(post: '/users/10/followings').to route_to(
      controller: 'followings',
      action: 'create',
      user_id: '10'
    )
  end

  it 'routes /users/:id/followings/:id to followings#destroy' do
    expect(delete: '/users/10/followings/20').to route_to(
      controller: 'followings',
      action: 'destroy',
      user_id: '10',
      id: '20'
    )
  end
end

