class Admin::OrdersController < ApplicationController

  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
    @order_detail = OrderDetail.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])
    @order.update(order_params)
    redirect_to request.referer
  end
  
  def customer
    @customer_order = Order.find(params[:customer_id])
    @customer_orders = Order.where(params[:customer_id])
  end

  def order_params
    params.require(:order).permit(:customer_id, :post_code, :address, :customer_name, :shipping_cost, :payment_method, :order_status)
  end
  
  def order_detail_params
    params.require(:order_detail).permit(:making_status,:amount,:price)
  end

end
