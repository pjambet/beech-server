require 'spec_helper'

describe 'routing to admin/badges' do
  it 'routes /admin/badges to admin/badges#index' do
    expect(get: '/admin/badges').to route_to(
      controller: 'admin/badges',
      action: 'index'
    )
  end

  it 'routes /admin/badges/new to admin/badges#new' do
    expect(get: '/admin/badges/new').to route_to(
      controller: 'admin/badges',
      action: 'new'
    )
  end

  it 'routes /admin/badges/:id to admin/badges#show' do
    expect(get: '/admin/badges/10').to route_to(
      controller: 'admin/badges',
      action: 'show',
      id: '10'
    )
  end

  it 'routes /admin/badges/:id/edit to admin/badges#edit' do
    expect(get: '/admin/badges/10/edit').to route_to(
      controller: 'admin/badges',
      action: 'edit',
      id: '10'
    )
  end

  it 'routes /admin/badges to admin/badges#create' do
    expect(post: '/admin/badges').to route_to(
      controller: 'admin/badges',
      action: 'create'
    )
  end

  it 'routes /admin/badges/:id to admin/badges#update' do
    expect(put: '/admin/badges/10').to route_to(
      controller: 'admin/badges',
      action: 'update',
      id: '10'
    )
  end

  it 'routes /admin/badges/:id/edit to admin/badges#destroy' do
    expect(delete: '/admin/badges/10').to route_to(
      controller: 'admin/badges',
      action: 'destroy',
      id: '10'
    )
  end

end

