class CreateBraintreeCustomers < ActiveRecord::Migration[5.1]
  def change
    create_table :braintree_customers do |t|
			t.string :braintree_customer_id
			t.belongs_to :user, index: true, foreign_key: true
			t.timestamps null: false

      t.timestamps
    end
  end
end
