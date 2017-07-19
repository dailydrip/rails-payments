class CreateSubscriptions < ActiveRecord::Migration[5.1]
  def change
    create_table :subscriptions do |t|
      t.string :plan_id
      t.money :amount
      t.string :description
      t.timestamps
    end
  end
end
