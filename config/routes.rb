BeerServer::Application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions' }

  namespace :api do
    scope 'my' do
      resource :profiles, path: 'profile', only: [:index, :show, :update]
    end
    resources :users, only: [:show, :index] do
      resources :checks, only: :index
      resources :awards, only: :index
      resources :followers, only: :index
      resources :followings, only: :index
      resource :profile, only: :index
    end

    match 'feed', to: 'feed#index'
    resources :profiles, only: :show
    resources :checks, only: [:index, :create]
    resources :awards, only: :index
    resources :followings, only: [:index, :create, :destroy]
    resources :followers, only: :index

    resources :beers, only: :index
  end

  namespace :admin do
    resources :beers
    resources :badges

    root to: 'beers#index'
  end

  namespace :me do
    root to: 'home#index'
  end

  resources :users, only: [:index, :show]

  root to: 'home#index'
end
