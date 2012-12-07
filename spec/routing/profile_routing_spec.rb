require 'spec_helper'

describe 'routing to profile' do
  it 'routes /profile to profile#index' do
    expect(get: '/profile').to route_to(
      controller: 'profile',
      action: 'index'
    )
  end

  it 'routes /profile/:id to profile#show' do
    expect(get: '/profile/20').to route_to(
      controller: 'profile',
      action: 'show',
      id: '20'
    )
  end

end

