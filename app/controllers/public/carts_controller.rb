class Public::CartsController < ApplicationController
  before_action :authenticate_customer!
  
  def index
    @carts = current_customer.carts
  end
  
  def update
    cart = Cart.find(params[:id])
    cart.update(cart_params)
    redirect_to carts_path
  end
  
  def destroy
    cart = Cart.find(params[:product_id])
    cart.destroy
    redirect_to carts_path
  end
  
  def destroy_all
    current_customer.carts.destroy_all
  end
  
  def create
    if current_customer.carts.find_by(product_id)
      cart.amount += params[:amount].to_i
    else
      current_customer.carts.build(product_id:).save
    end
      
  end
  
  private
  def cart_params
      params.require(:cart).permit(:product_id, :amount)
  end

end
