BeerServer::Application.routes.draw do
  apipie

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    passwords: 'users/passwords'
  }

  namespace :api do
    scope 'my' do
      resources :feed, only: :index
      resources :notifications, only: :index
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
      resources :notifications, only: :index
      resource :profile, only: :show
      resources :beers, only: :index, controller: 'my_beers'
      resources :badges, only: :index, controller: 'my_badges'
      resources :followers, only: :index
      resources :followings, only: :index
    end

    resources :events, only: [] do
      resources :likes, only: [:index, :create] do
        delete :destroy, on: :collection
      end
      resources :comments, only: [:index, :create, :destroy]
    end

    resources :checks, only: :create
    resources :beers, only: [:index, :create]
    resources :journal_entries, only: :index
  end

  namespace :admin do
    resources :beers do
      put :accept, on: :member
      put :reject, on: :member
    end
    resources :badges
    resources :users
    resources :events, only: :index

    root to: 'beers#index'
  end

  resources :users, only: [:index, :show]

  if Rails.env.development?
    mount MailPreview => 'mail_view'
  end

  root to: 'home#index'
end
