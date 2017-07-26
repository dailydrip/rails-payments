class BraintreeWebhookController < ApplicationController
  skip_before_action :verify_authenticity_token

  def webhook
    BraintreeWebhookHandler.new(current_user, bt_signature_param, bt_payload_param).call
    head :ok
  end

  private

  def bt_signature_param
    params[:bt_signature]
  end

  def bt_payload_param
    params[:bt_payload]
  end

  def bt_challenge_param
    params[:bt_challenge]
  end
end
