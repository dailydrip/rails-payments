class SubscriptionsController < ApplicationController
  def index
    gon.client_token = generate_braintree_client_token
    @subscriptions = Subscription.all
  end

  def show
  end

  def subscribe
    result = Braintree::Subscription.create(
      :payment_method_nonce => params[:payment_method_nonce],
      :plan_id => "monhtly"
    )
    if result.success?
      redirect_back(fallback_location: root_path, notice: 'Everything was fine!')
    else
      redirect_back(fallback_location: root_path, notice: 'Something went wrong! :/')
    end
  end
end
