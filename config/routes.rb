BeerServer::Application.routes.draw do
  devise_for :users, controllers: { registrations: "users/registrations" }

  resources :users, only: :show

  root to: "home#index"
end
