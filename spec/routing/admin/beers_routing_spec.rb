require 'spec_helper'

describe 'routing to admin/beers' do
  it 'routes /admin/beers to admin/beers#index' do
    expect(get: '/admin/beers').to route_to(
      controller: 'admin/beers',
      action: 'index'
    )
  end

  it 'routes /admin/beers/new to admin/beers#new' do
    expect(get: '/admin/beers/new').to route_to(
      controller: 'admin/beers',
      action: 'new'
    )
  end

  it 'routes /admin/beers/:id to admin/beers#show' do
    expect(get: '/admin/beers/10').to route_to(
      controller: 'admin/beers',
      action: 'show',
      id: '10'
    )
  end

  it 'routes /admin/beers/:id/edit to admin/beers#edit' do
    expect(get: '/admin/beers/10/edit').to route_to(
      controller: 'admin/beers',
      action: 'edit',
      id: '10'
    )
  end

  it 'routes /admin/beers to admin/beers#create' do
    expect(post: '/admin/beers').to route_to(
      controller: 'admin/beers',
      action: 'create'
    )
  end

  it 'routes /admin/beers/:id to admin/beers#update' do
    expect(put: '/admin/beers/10').to route_to(
      controller: 'admin/beers',
      action: 'update',
      id: '10'
    )
  end

  it 'routes /admin/beers/:id/edit to admin/beers#destroy' do
    expect(delete: '/admin/beers/10').to route_to(
      controller: 'admin/beers',
      action: 'destroy',
      id: '10'
    )
  end

end

