BeerServer::Application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions' }

  namespace :api do
    resources :users, only: [:show, :index] do
      resources :checks, only: [:index, :create]
      resources :awards, only: :index
      resources :followers, only: :index
      resources :followings, only: :index
      resources :profile, only: :index

      get :search, on: :collection
    end
    match 'feed', to: 'feed#index'
    resources :profile, only: [:index, :show]
    resources :checks, only: [:index, :create]
    resources :awards, only: :index
    resources :followings, only: [:index, :create, :destroy]
    resources :followers, only: :index

    resources :beers, only: :index
  end

  namespace :admin do
    resources :beers

    root to: 'beers#index'
  end

  namespace :me do
    root to: 'home#index'
  end

  resources :users, only: [:index, :show]

  root to: 'home#index'
end
