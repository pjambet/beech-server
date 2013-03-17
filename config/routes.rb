BeerServer::Application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions' }

  offline = if Rails.env.production?
    Rack::Offline.configure root: "#{Rails.root}/public", cache: true do
      cache 'assets/application.css'
      cache 'assets/application.js'

      network '*'
    end
  else
    Rack::Offline.configure cache: false do
      # TODO: Find a way to list the files automatically.
      # There's no application.css and application.js in development mode.
      network '*'
    end
  end
  match "/cache.manifest" => offline

  namespace :api do
    scope 'my' do
      resources :feed, only: :index
      resource :profile, only: [:show, :update]
      resources :beers, only: :index, controller: 'my_beers'
      resources :badges, only: :index, controller: 'my_badges'
      resources :followings, only: [:index, :create] do
        delete :destroy, on: :collection
      end
      resources :followers, only: :index
    end

    resources :users, only: :index do
      resources :feed, only: :index
      resource :profile, only: :show
      resources :beers, only: :index, controller: 'my_beers'
      resources :badges, only: :index, controller: 'my_badges'
      resources :followers, only: :index
      resources :followings, only: :index
    end

    resources :checks, only: :create
    resources :beers, only: [:index, :create]
  end

  namespace :admin do
    resources :beers do
      put :accept, on: :member
      put :reject, on: :member
    end
    resources :badges
    resources :users

    root to: 'beers#index'
  end

  scope 'me' do
    root to: 'home#index'
  end

  resources :users, only: [:index, :show]

  root to: 'home#index'
end
