class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.integer :customer_id, null: false
      t.string :post_code, null: false
      t.string :adress, null: false
      t.string :customer_name, null: false
      t.integer :shipping_cost, null: false
      t.integer :payment_method, null: false
      t.integer :order_status, null: false
      t.timestamps
    end
  end
end
