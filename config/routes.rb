Rails.application.routes.draw do
  devise_for :users
  get '/subscriptions' => 'subscriptions#index'
  post '/subscriptions/subscribe' => 'subscriptions#subscribe'
  post '/subscriptions/custom_subscribe' => 'subscriptions#custom_subscribe'

  resources :products, only: %i[index show]
  post '/products/buy' => 'products#buy'
  root to: 'products#index'
end
