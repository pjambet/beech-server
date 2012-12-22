require 'spec_helper'

describe 'routing to awards' do
  it 'routes /api/awards to api/awards#index' do
    expect(get: '/api/awards').to route_to(
      controller: 'api/awards',
      action: 'index'
    )
  end

end

