class BraintreeSubscription < ApplicationRecord
  belongs_to :braintree_customer
  belongs_to :braintree_plan
  scope :active, lambda { all }

  def plan
    braintree_plan
  end

  def card_last4
    nil
  end

  def card_expiration
    nil
  end

  def trial_end
    nil
  end

  def trialing?
    false
  end

  def canceled?
    false
  end

  def remote_status
    braintree_status.downcase
  end

  def cancel_at_period_end
    false
  end

  def sync!(subscription)
    db_plan = BraintreePlan.find_by(braintree_id: subscription.plan_id)
    update_attributes(
      braintree_status: subscription.status,
      braintree_plan_id: db_plan.try(:id),
      start: subscription.first_billing_date,
      current_period_start: subscription.billing_period_start_date,
      current_period_end: subscription.billing_period_end_date,
      canceled_at: subscription.status_history.detect { |t| t.status == 'Canceled' }.try(:timestamp),
      amount: (subscription.price * BigDecimal.new('100')).to_i
    )
  end

end
