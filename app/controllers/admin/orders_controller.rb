class Admin::OrdersController < ApplicationController
  
  def index
    @orders = Order.all
  end
  
  def show
    @order = Order.find(params[:id])
    @order.update(order_params)
    redirect_to admin_order_path(@order)

  end
  
  def update
  end
  
  def order_params
    params.require(:order).permit(:status)
  end
  
end
