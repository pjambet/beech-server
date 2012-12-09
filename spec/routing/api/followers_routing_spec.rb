require 'spec_helper'

describe 'routing to followers' do
  it 'routes /api/followers to api/followers#index' do
    expect(get: '/api/followers').to route_to(
      controller: 'api/followers',
      action: 'index'
    )
  end

end

