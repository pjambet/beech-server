require 'spec_helper'

describe 'routing to user checks' do
  it 'routes /users/checks to checks#index' do
    expect(get: '/users/10/checks').to route_to(
      controller: 'checks',
      action: 'index',
      user_id: '10'
    )
  end


  it 'routes /users/checks to checks#create' do
    expect(post: '/users/10/checks').to route_to(
      controller: 'checks',
      action: 'create',
      user_id: '10'
    )
  end

end

