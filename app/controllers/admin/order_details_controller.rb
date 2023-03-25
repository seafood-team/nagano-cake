class Admin::OrderDetailsController < ApplicationController


  def update
    order_detail = OrderDetail.find(params[:id])
    order_detail.update(order_detail_params)

    case order_detail.making_status
      when 'making'
        order_detail.order.update(order_status: 'in_production')
      when 'finish_making'
        if order_detail.order.order_details.all?{|order_detail| order_detail.making_status == 'finish_making'}
          order_detail.order.update(order_status: 'preparing_delivery')
        end
    end
    redirect_to admin_order_path(order_detail.order)
  end

  def order_detail_params
    params.require(:order_detail).permit(:order_id, :making_status,:amount,:price)
  end

end
