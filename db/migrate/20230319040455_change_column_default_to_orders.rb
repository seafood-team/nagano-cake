class ChangeColumnDefaultToOrders < ActiveRecord::Migration[6.1]
  def change
    change_column_default :orders, :payment_method, from: nil, to: "0"
    change_column_default :orders, :order_status, from: nil, to: "0"
  end
end
