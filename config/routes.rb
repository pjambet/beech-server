BeerServer::Application.routes.draw do
  devise_for :users, controllers: { registrations: "users/registrations" }

  resources :users, only: :show do
    resources :checks, only: [:index, :create]
  end


  root to: "home#index"
end
