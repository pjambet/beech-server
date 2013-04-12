require 'spec_helper'

describe 'routing to likes' do
  it 'routes /api/my/feed to feed#index' do
    expect(get: '/api/events/2/likes').to route_to(
      controller: 'api/likes',
      action: 'index',
      event_id: '2'
    )
  end

  it 'routes /api/my/feed to feed#create' do
    expect(post: '/api/events/2/likes').to route_to(
      controller: 'api/likes',
      action: 'create',
      event_id: '2'
    )
  end

  it 'routes /api/my/feed to feed#delete' do
    expect(delete: '/api/events/2/likes').to route_to(
      controller: 'api/likes',
      action: 'destroy',
      event_id: '2'
    )
  end
end

