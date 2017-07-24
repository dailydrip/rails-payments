class SubscriptionsController < ApplicationController
  before_action :authenticate_user!

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
      Subscription.create(amount: params[:amount], user: current_user, plan_id: params[:plan_id])
      redirect_back(fallback_location: root_path, notice: 'Everything was fine!')
    else
      redirect_back(fallback_location: root_path, notice: 'Something went wrong! :/')
    end
  end
end
