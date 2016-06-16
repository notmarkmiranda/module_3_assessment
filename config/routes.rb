Rails.application.routes.draw do
  root 'items#index'

  resources :items,  only: [:index, :show]
  resources :orders, only: [:index, :show]
  resources :users,  only: [:index, :show]

  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      resources :items, only: [:index, :show, :destroy, :create]
    end
  end

  get "/search", to: "results#index"
  get "/stores/:store_id", to: "results#show", as: "store"
end
