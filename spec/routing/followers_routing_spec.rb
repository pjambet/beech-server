require 'spec_helper'

describe 'routing to followers' do
  it 'routes /followers to followers#index' do
    expect(get: '/followers').to route_to(
      controller: 'followers',
      action: 'index'
    )
  end

end

