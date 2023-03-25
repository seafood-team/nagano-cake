class HomesController < ApplicationController
  def top
    @genres = Genre.all
    @products = Product.latest
    @random = Product.order("Random()").limit(4)
  end
  
  def about
  end
end
