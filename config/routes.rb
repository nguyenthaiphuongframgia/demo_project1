Rails.application.routes.draw do
  root "static_pages#index"
  post "/signin", to: "sessions#create"
  delete "/signout", to: "sessions#destroy"
  resources :users
  resources :cart_items
  resources :products
  resources :ratings
  resources :suggest_products
  resources :carts

  namespace :admin do
    resources :charts
    resources :users
    resources :products 
    resources :orders
    resources :suggest_products
    resources :categories
    resources :csv do
      collection { post :import }
    end
    resources :xls
  end
end
