class Admin::ProductsController < ApplicationController
  
  
    
  def index
    @products = Product.page(params[:page]).per(4)
  end
  
  def new
    @products = Product.new
  end

  def show
    @product = Product.find(params[:id])
  end
  
  def create
    @product = Product.new(product_params)
    if @product.save
      flash.now[:success] = "商品の新規登録が完了しました。"
      redirect_to admin_product_path(@product)
    else
      flash.now[:danger] = "商品の新規登録に失敗しました。"
      render :new
    end
  end
  
  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.new(product_params)
    if @product.update
      flash.now[:success] = "商品の新規登録が完了しました。"
      redirect_to admin_product_path(@product)
    else
      flash.now[:danger] = "商品の新規登録に失敗しました。"
      render :new
    end
  end
  
  private
  def product_params
    params.permit(:image, :product_name, :introduct, :no_tax, :sale_status)
  end
end
