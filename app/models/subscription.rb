class Subscription < ApplicationRecord
  belongs_to :user

  def sync!(subscription)
    update_attributes(
      status: subscription.status
    )
  end
end
