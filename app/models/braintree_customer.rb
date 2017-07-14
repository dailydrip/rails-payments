class BraintreeCustomer < ApplicationRecord
  belongs_to :user
  has_many :braintree_subscriptions

  def subscriptions
    braintree_subscriptions
  end
end
