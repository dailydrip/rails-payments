Rails.application.routes.draw do
  devise_for :users
  get '/subscriptions' => 'subscriptions#index'
  post '/subscriptions/subscribe' => 'subscriptions#subscribe'
  post '/subscriptions/custom_subscribe' => 'subscriptions#custom_subscribe'
  get 'subscriptions/user_invoice' => 'subscriptions#invoice', as: 'invoice_pdf'

  post 'braintree_webhook' => 'braintree_webhook#webhook'

  resources :products, only: %i[index show]
  post '/products/buy' => 'products#buy'
  root to: 'products#index'
end
