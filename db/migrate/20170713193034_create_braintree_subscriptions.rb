class CreateBraintreeSubscriptions < ActiveRecord::Migration[5.1]
  def change
    create_table :braintree_subscriptions do |t|
      t.string :braintree_subscription_id
      t.belongs_to :braintree_customer, index: true, foreign_key: true
      t.references :braintree_plan
      t.timestamps null: false

      t.timestamps
    end
  end
end
