require 'spec_helper'

describe 'routing to user followings' do
  it 'routes /api/users/:id/followings to api/followings#index' do
    expect(get: '/api/users/10/followings').to route_to(
      controller: 'api/followings',
      action: 'index',
      user_id: '10'
    )
  end

end

