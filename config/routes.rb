Rails.application.routes.draw do
  resources :products, only: %i[index show]
  root to: 'products#index'
end
