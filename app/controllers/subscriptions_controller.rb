class SubscriptionsController < ApplicationController
  before_action :authenticate_user!

  def index
    gon.client_token = generate_braintree_client_token
    @subscriptions = Subscription.all
  end

  def show; end

  def custom_subscribe
    result_payment = Braintree::PaymentMethod.create(
      customer_id: current_user.customer_id_braintree,
      payment_method_nonce: params[:payment_method_nonce]
    )

    if result_payment.success?
      result = Braintree::Subscription.create(
        payment_method_token: result_payment.payment_method.token,
        plan_id: params[:plan_id]
      )
      handle_result_subscription(result)
    else
      redirect_back(fallback_location: root_path, notice: 'Something went wrong creating your payment method! :/')
    end
  end

  def subscribe
    result = Braintree::Subscription.create(
      payment_method_nonce: params[:payment_method_nonce],
      plan_id: params[:plan_id]
    )

    handle_result_subscription(result)
  end

  private def handle_result_subscription(result)
    if result.success?
      Subscription.create(amount: params[:amount], user: current_user,
                          plan_id: result.subscription.plan_id,
                          status: result.subscription.status,
                          braintree_subscription_id: result.subscription.id)
      redirect_back(fallback_location: root_path, notice: 'Everything was fine!')
    else
      redirect_back(fallback_location: root_path, notice: 'Something went wrong! :/')
    end
  end
end
