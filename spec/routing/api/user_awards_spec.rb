require 'spec_helper'

describe 'routing to user awards' do
  it 'routes /api/users/awards to api/awards#index' do
    expect(get: '/api/users/10/awards').to route_to(
      controller: 'api/awards',
      action: 'index',
      user_id: '10'
    )
  end

end

