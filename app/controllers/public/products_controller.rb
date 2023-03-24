class Public::ProductsController < ApplicationController
  
  def show
    @product = Product.find(params[:id])
    @cart = Cart.new
    @genres = Genre.all
  end
  
  def index
    @genres = Genre.all
    if params[:genre_id]
		  @genre = Genre.find(params[:genre_id])
		  @products = @genre.products.where(sale_status: true)
    else
      @products = Product.latest.page(params[:page]).per(8)
    end
    if params[:no_tax_low_to_high]
      @products = Product.no_tax_low_to_high
    elsif params[:no_tax_high_to_low]
      @products = Product.no_tax_high_to_low
    end
    
  end
  
  def search
    @products = Product.page(params[:page]).per(5)
    @word_for_search = Genre.find(params[:word_for_search])
    @search_products = Product.where(genre: params[:word_for_search])
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
