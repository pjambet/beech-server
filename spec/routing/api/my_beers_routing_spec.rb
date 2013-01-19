require 'spec_helper'

describe 'routing to my beers' do
  it 'routes /api/my/beers to api/beers#index' do
    expect(get: '/api/my/beers').to route_to(
      controller: 'api/my_beers',
      action: 'index'
    )
  end

  it 'routes /api/users/10/beers to api/beers#index' do
    expect(get: '/api/users/10/beers').to route_to(
      controller: 'api/my_beers',
      action: 'index',
      user_id: '10'
    )
  end

end

