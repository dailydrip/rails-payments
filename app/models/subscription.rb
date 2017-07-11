class Subscription
  attr_reader :wrapped
  delegate :plan, to: :wrapped
  delegate :customer_id, to: :wrapped
  delegate :trialing?, to: :wrapped
  delegate :remote_status, to: :wrapped
  delegate :canceled?, to: :wrapped
  delegate :cancel_at_period_end, to: :wrapped
  delegate :created_at, to: :wrapped
  delegate :updated_at, to: :wrapped
  delegate :current_period_start, to: :wrapped
  delegate :current_period_end, to: :wrapped
  delegate :is_a?, to: :wrapped
  delegate :trial_end, to: :wrapped
  delegate :start, to: :wrapped
  delegate :amount, to: :wrapped
  delegate :card_last4, to: :wrapped
  delegate :card_expiration, to: :wrapped

  def initialize(wrapped)
    @wrapped = wrapped
  end
end
