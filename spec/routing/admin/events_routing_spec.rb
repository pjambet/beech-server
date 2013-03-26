require 'spec_helper'

describe 'routing to admin/events' do
  it 'routes /admin/events to admin/events#index' do
    expect(get: '/admin/events').to route_to(
      controller: 'admin/events',
      action: 'index'
    )
  end

end

