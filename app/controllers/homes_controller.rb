class HomesController < ApplicationController
  def top
    @genres = Genre.all
    @products = Product.latest
  end
  
  def about
  end
end
