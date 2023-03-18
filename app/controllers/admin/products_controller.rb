class Admin::ProductsController < ApplicationController
  
  
    
  def index
    @products = Product.page(params[:page]).per(4)
  end
  
  def new
    @products = Product.new
  end

  def show
  end
  
  def create
  end
  
  def edit
  end

  def update
  end
end
