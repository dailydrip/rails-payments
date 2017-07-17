class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :name
      t.money :amount, default: 0
      t.string :image_url
      t.timestamps
    end
  end
end
