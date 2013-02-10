require 'spec_helper'

describe 'routing to checks' do
  it 'routes /api/check to api/checks#create' do
    expect(post: '/api/checks').to route_to(
      controller: 'api/checks',
      action: 'create'
    )
  end

end

