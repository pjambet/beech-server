require 'spec_helper'

describe 'routing to users' do
  it 'routes /users/sign_in to sessions#new' do
    expect(get: '/users/sign_in').to route_to(
      controller: 'users/sessions',
      action: 'new'
    )
  end

  it 'routes /users/sign_up to registrations#create' do
    expect(get: '/users/sign_up').to route_to(
      controller: 'users/registrations',
      action: 'new'
    )
  end

  it 'routes /users to users#index' do
    expect(get: '/users').to route_to(
      controller: 'users',
      action: 'index'
    )
  end

  it 'routes /users/:id to users#show' do
    expect(get: '/users/10').to route_to(
      controller: 'users',
      action: 'show',
      id: '10'
    )
  end

  it 'routes /users/search to users#search' do
    expect(get: '/users/search').to route_to(
      controller: 'users',
      action: 'search'
    )
  end

end

