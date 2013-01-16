require 'spec_helper'

describe 'routing to my badges' do
  it 'routes /api/my/badges to api/badges#index' do
    expect(get: '/api/my/badges').to route_to(
      controller: 'api/my_badges',
      action: 'index'
    )
  end

end

