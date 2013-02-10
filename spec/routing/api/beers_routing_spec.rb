require 'spec_helper'

describe 'routing to beers' do
  it 'routes /api/beers to api/beers#index' do
    expect(get: '/api/beers').to route_to(
      controller: 'api/beers',
      action: 'index'
    )
  end

  it 'routes /api/beers to api/beers#create' do
    expect(post: '/api/beers').to route_to(
      controller: 'api/beers',
      action: 'create'
    )
  end

end

