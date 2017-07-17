Rails.application.routes.draw do
  resources :products, only: [:index, :show]
  root to: 'products#index'
end
