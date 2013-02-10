require 'spec_helper'

describe 'routing to admin/users' do
  it 'routes /admin/users to admin/users#index' do
    expect(get: '/admin/users').to route_to(
      controller: 'admin/users',
      action: 'index'
    )
  end

  it 'routes /admin/users/new to admin/users#new' do
    expect(get: '/admin/users/new').to route_to(
      controller: 'admin/users',
      action: 'new'
    )
  end

  it 'routes /admin/users/:id to admin/users#show' do
    expect(get: '/admin/users/10').to route_to(
      controller: 'admin/users',
      action: 'show',
      id: '10'
    )
  end

  it 'routes /admin/users/:id/edit to admin/users#edit' do
    expect(get: '/admin/users/10/edit').to route_to(
      controller: 'admin/users',
      action: 'edit',
      id: '10'
    )
  end

  it 'routes /admin/users to admin/users#create' do
    expect(post: '/admin/users').to route_to(
      controller: 'admin/users',
      action: 'create'
    )
  end

  it 'routes /admin/users/:id to admin/users#update' do
    expect(put: '/admin/users/10').to route_to(
      controller: 'admin/users',
      action: 'update',
      id: '10'
    )
  end

  it 'routes /admin/users/:id/edit to admin/users#destroy' do
    expect(delete: '/admin/users/10').to route_to(
      controller: 'admin/users',
      action: 'destroy',
      id: '10'
    )
  end

end

