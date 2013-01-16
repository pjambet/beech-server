require 'spec_helper'

describe 'routing to my profile' do
  it 'routes /api/my/profile to api/profile#show' do
    expect(get: '/api/my/profile').to route_to(
      controller: 'api/profiles',
      action: 'show'
    )
  end

end

