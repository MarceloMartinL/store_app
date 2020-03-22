Rails.application.routes.draw do
  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
  		resources :stores, except: [:new] do
  			resources :products, shallow: true
  		end
  	end
  end
end
