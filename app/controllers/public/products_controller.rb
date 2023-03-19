class Public::ProductsController < ApplicationController
  
  def show
    @product = Product.find(params[:id])
    @cart = Cart.new
  end
  
  def index
    @product = Product.all
  end
  
  private
  
  def get_products(params)
    return Product.all, 'default' unless params[:latest] || params[:price_high_to_low] || params[:price_low_to_high]
    return Product.latest, 'latest' if params[:latest]
    return Product.price_high_to_low, 'price_high_to_low' if params[:price_high_to_low]
    return Product.price_low_to_high, 'price_low_to_high' if params[:price_low_to_high]
  end
  
end
