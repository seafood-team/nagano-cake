class ChangeColumnDefaultToOrders < ActiveRecord::Migration[6.1]
  def change
    change_column_default :orders, :order_status, null: false, from: nil , to: "0"
  end
end
