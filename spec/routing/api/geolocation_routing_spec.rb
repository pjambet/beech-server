require 'spec_helper'

describe 'routing to geolocation' do
  it 'routes /api/geolocation to geolocation#show' do
    expect(get: '/api/geolocation').to route_to(
      controller: 'api/geolocation',
      action: 'show'
    )
  end
end

