class Public::ProductsController < ApplicationController
  
  def show
    @product = Product.find(params[:id])
    @cart = Cart.new
  end
  
  def index
    @products = Product.all
  end
  
  def search
    @products = Product.page(params[:page]).per(5)
    @word_for_search = Genre.find(params[:word_for_search])
    @search_products = Product.where(genre: params[:word_for_search])
  end
  
  private
  
  def get_products(params)
    return Product.all, 'default' unless params[:latest] || params[:price_high_to_low] || params[:price_low_to_high]
    return Product.latest, 'latest' if params[:latest]
    return Product.price_high_to_low, 'price_high_to_low' if params[:price_high_to_low]
    return Product.price_low_to_high, 'price_low_to_high' if params[:price_low_to_high]
  end
  
end
