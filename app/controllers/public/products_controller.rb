class Public::ProductsController < ApplicationController
  
  def show
    @product = Product.find(params[:id])
    @cart = Cart.new
  end
  
  def index
    @products = Product.latest
    if params[:no_tax_low_to_high]
      @products = Product.no_tax_low_to_high
    elsif params[:no_tax_high_to_low]
      @products = Product.no_tax_high_to_low
    end
  end
  
  private
  
  def product_params
    params.require(:product).permit(:no_tax, :product_name, :image)
  end
  
  def get_products(params)
    return Product.all, 'default' unless params[:latest] || params[:no_tax_high_to_low] || params[:no_tax_low_to_high]
    return Product.latest, 'latest' if params[:latest]
    return Product.price_high_to_low, 'price_high_to_low' if params[:no_tax_high_to_low]
    return Product.price_low_to_high, 'price_low_to_high' if params[:no_tax_low_to_high]
  end
  
end
