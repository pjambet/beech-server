require 'spec_helper'

describe 'routing to feed' do
  it 'routes /feed to feed#index' do
    expect(get: '/feed').to route_to(
      controller: 'feed',
      action: 'index'
    )
  end

end

