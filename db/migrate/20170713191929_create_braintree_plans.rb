class CreateBraintreePlans < ActiveRecord::Migration[5.1]
  def change
    create_table :braintree_plans do |t|
      t.string   'name'
      t.string   'braintree_id'
      t.string   'interval'
      t.integer  'amount'
      t.timestamps

      t.timestamps
    end
  end
end
