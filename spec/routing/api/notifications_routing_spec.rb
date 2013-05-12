require 'spec_helper'

describe 'routing to /api/my/notifications' do
  it 'routes /api/my/notifications to api/notifications#index' do
    expect(get: '/api/my/notifications').to route_to(
      controller: 'api/notifications',
      action: 'index'
    )
  end

  it 'routes /api/users/:id/notifications to api/notifications#index' do
    expect(get: '/api/users/1/notifications').to route_to(
      controller: 'api/notifications',
      action: 'index',
      user_id: '1'
    )
  end
end

