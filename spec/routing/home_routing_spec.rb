require 'spec_helper'

describe 'routing to home' do
  it 'routes / to home#index' do
    expect(get: '/').to route_to(
      controller: 'home',
      action: 'index'
    )
  end

end

