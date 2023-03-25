class Public::CartsController < ApplicationController
  before_action :authenticate_customer!
  
  def index
    @carts = current_customer.carts.all
    @total = 0
  end
  
  def update
    cart = Cart.find(params[:id])
    cart.update(amount: (params[:cart][:amount]).to_i)
    redirect_to request.referer
  end
  
  def destroy
    cart = Cart.find(params[:id])
    cart.destroy
    redirect_to request.referer
  end
  
  def destroy_all
    current_customer.carts.destroy_all
    redirect_to request.referer
  end
  
  def create
    @cart = current_customer.carts.new(cart_params)
    if current_customer.carts.find_by(product_id: params[:cart][:product_id]).present?
      cart = current_customer.carts.find_by(product_id: params[:cart][:product_id])
      cart.amount += (params[:cart][:amount]).to_i
      cart.save
      redirect_to carts_path
    else
      @cart.save
      redirect_to carts_path
    end
      
  end
  
  private
  def cart_params
      params.require(:cart).permit(:product_id, :amount, :customer_id)
  end

end
