Rails.application.routes.draw do
  get "admin" => "admin#index"

  resources :support_requests, only: %i[index update]

  resources :users
  resource :session
  resources :passwords, param: :token

  resources :products

  scope "(:locale)" do
    resources :orders
    resources :line_items
    resources :carts

    root "store#index", as: "store_index", via: :all
    get "store/index", as: "store_index_page"
  end

  # Health status
  get "up" => "rails/health#show", as: :rails_health_check

  # PWA routes
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
end