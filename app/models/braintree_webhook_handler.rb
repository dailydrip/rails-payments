class BraintreeWebhookHandler
  attr_reader :notification

  delegate :subscription, to: :notification
  delegate :kind, to: :notification

  def initialize(user, bt_signature, bt_payload)
    @user = user
    @notification = Braintree::WebhookNotification.parse(
      bt_signature,
      bt_payload
    )
  end

  def call
    case kind
    when Braintree::WebhookNotification::Kind::SubscriptionCanceled
      handle_subscription_canceled
    else
      log_unhandled_kind
    end
  end

  def db_subscription
    Subscription.find_by(braintree_subscription_id: subscription.id)
  end

  def handle_subscription_canceled
    Rails.logger.info "#{self.class} - #{__method__}"
    handle_common
  end

  def log_unhandled_kind
    Rails.logger.warn "[webhooks] Unhandled braintree webhook kind: #{kind}"
  end

  private def handle_common
    if db_subscription
      db_subscription.sync!(subscription)
    else
      Rails.logger.warn "Couldn't find BraintreeSubscription for #{subscription.id}"
    end
  end
end
