Rails.application.routes.draw do
  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :stores, except: [:new] do
        resources :products, shallow: true
        resources :product_stores, only: [:index, :create, :destroy]
        resources :orders, shallow: true
      end
    end
  end
end
