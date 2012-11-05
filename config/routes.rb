BeerServer::Application.routes.draw do
  devise_for :users
  resources :users, except: :destroy

  root to: "home#index"
end
