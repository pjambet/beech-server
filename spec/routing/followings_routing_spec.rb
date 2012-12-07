require 'spec_helper'

describe 'routing to followings' do
  it 'routes /followings to followings#index' do
    expect(get: '/followings').to route_to(
      controller: 'followings',
      action: 'index'
    )
  end

end

