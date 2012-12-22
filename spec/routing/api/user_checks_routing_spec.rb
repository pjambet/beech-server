require 'spec_helper'

describe 'routing to user checks' do
  it 'routes /api/users/checks to api/checks#index' do
    expect(get: '/api/users/10/checks').to route_to(
      controller: 'api/checks',
      action: 'index',
      user_id: '10'
    )
  end


  it 'routes /api/users/checks to api/checks#create' do
    expect(post: '/api/users/10/checks').to route_to(
      controller: 'api/checks',
      action: 'create',
      user_id: '10'
    )
  end

end

