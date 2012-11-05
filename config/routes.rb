BeerServer::Application.routes.draw do
  devise_for :users

  resources :users, only: :show

  root to: "home#index"
end
