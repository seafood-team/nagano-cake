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
    @order_details = OrderDetail.where(order_id: params[:id])
    if @order.update(order_params)
      @order_details.update_all(making_status: 1) if @order.order_status == "payment_confirmation"
    ## ①注文ステータスが「入金確認」とき、製作ステータスを全て「製作待ち」に更新する
    end
    redirect_to admin_order_path(@order)
  end

  def customer
    @customer_order = Customer.find(params[:customer_id])
  end

  def order_params
    params.require(:order).permit(:customer_id, :post_code, :address, :customer_name, :shipping_cost, :payment_method, :order_status)
  end

  def order_detail_params
    params.require(:order_detail).permit(:making_status,:amount,:price)
  end

end
