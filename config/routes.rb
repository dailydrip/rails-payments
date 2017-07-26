Rails.application.routes.draw do
  devise_for :users
  get '/subscriptions' => 'subscriptions#index'
  post '/subscriptions/subscribe' => 'subscriptions#subscribe'
  post '/subscriptions/custom_subscribe' => 'subscriptions#custom_subscribe'

  post 'braintree_webhook' => 'braintree_webhook#webhook'
  get 'braintree_webhook' => 'braintree_webhook#get_webhook'

  resources :products, only: %i[index show]
  post '/products/buy' => 'products#buy'
  root to: 'products#index'
end
