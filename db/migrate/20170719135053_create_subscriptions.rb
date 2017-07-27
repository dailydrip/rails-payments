class CreateSubscriptions < ActiveRecord::Migration[5.1]
  def change
    create_table :subscriptions do |t|
      t.string :plan_id
      t.money :amount
      t.string :description
      t.belongs_to :user
      t.string :braintree_subscription_id
      t.string :braintree_transaction_id
      t.string :status
      t.timestamps
    end
  end
end
