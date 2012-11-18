BeerServer::Application.routes.draw do
  devise_for :users, controllers: { registrations: "users/registrations" }

  resources :users, only: :show do
    resources :checks, only: [ :index, :create ]
    resources :followings, only: [ :index, :create ]
    resources :followers, only: :index
    get :search, on: :collection
  end

  resources :beers, only: :index

  match "feed", to: "feed#index"

  root to: "home#index"
end
