require 'spec_helper'

describe 'routing to feed' do
  it 'routes /api/feed to feed#index' do
    expect(get: '/api/feed').to route_to(
      controller: 'api/feed',
      action: 'index'
    )
  end

end

