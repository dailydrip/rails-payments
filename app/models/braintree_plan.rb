class BraintreePlan < ApplicationRecord
  validates :amount, presence: true
  validates :interval, presence: true
  validates :braintree_id, presence: true
  validates :name, presence: true
  validates :braintree_id, uniqueness: true
  validates :braintree_id,
    inclusion: {
      in: lambda do |_x|
            BraintreePlan.pluck('DISTINCT braintree_id')
          end,
      message: 'not a valid subscription plan'
    }

  has_many :subscriptions, class_name: 'BraintreeSubscription'

  scope :available_for_signup, lambda {
    where(braintree_id: ['all-you-can-eat-may-2017', 'all-you-can-eat-annual-dec-2016'])
  }

  def remote_id
    braintree_id
  end

  def price
    amount
  end

  def pretty_name
    case braintree_id
    when 'anual'
      'Our Plan Annual'
    when 'monthly'
      'Our Plan Monthly'
    else
      name
    end
  end

  def name_amount_month
    "#{pretty_name} ($#{amount / 100}/#{interval})"
  end

  def redirect_path(_subscription)
    '/'
  end
end
