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
    @product = Product.find(params[:id])
    if @product.update(product_params)
      flash[:success] = "商品の更新が完了しました。"
      redirect_to admin_product_path(@product)
    else
      flash[:danger] = "商品の更新に失敗しました。"
      render :edit
    end
  end
  
  private
  def product_params
    params.require(:product).permit(:image, :product_name, :introduct, :no_tax, :sale_status, :genre_id)

  end
end
