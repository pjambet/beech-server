require 'spec_helper'

describe 'routing to user followers' do
  it 'routes /users/:id/followers to followers#index' do
    expect(get: '/users/10/followers').to route_to(
      controller: 'followers',
      action: 'index',
      user_id: '10'
    )
  end
end

