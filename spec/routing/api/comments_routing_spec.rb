require 'spec_helper'

describe 'routing to comments' do
  it 'routes /api/my/feed to feed#index' do
    expect(get: '/api/events/2/comments').to route_to(
      controller: 'api/comments',
      action: 'index',
      event_id: '2'
    )
  end

  it 'routes /api/my/feed to feed#create' do
    expect(post: '/api/events/2/comments').to route_to(
      controller: 'api/comments',
      action: 'create',
      event_id: '2'
    )
  end

  it 'routes /api/my/feed to feed#delete' do
    expect(delete: '/api/events/2/comments/2/').to route_to(
      controller: 'api/comments',
      action: 'destroy',
      event_id: '2',
      id: '2'
    )
  end
end

