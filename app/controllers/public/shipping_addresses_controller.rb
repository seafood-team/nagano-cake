class Public::ShippingAddressesController < ApplicationController

  def index
    @shipping_address = ShippingAddress.new
    @shipping_addresses = ShippingAddress.page(params[:page]).per(1)
    @shipping_addresses = @shipping_addresses.where(customer_id: current_customer.id)
  end

  def create
    # 新規作成する配送先データを格納
    @shipping_address = ShippingAddress.new(shipping_address_params)
    @shipping_address.customer_id = current_customer.id

    if @shipping_address.save
      flash[:notice] = "You have created book successfully."
      # 配送先登録画面リダイレクト
      redirect_to '/shipping_addresses'
    else
      @shipping_addresses = ShippingAddress.all
      render :index
    end
  end

  def edit
    @shipping_address = ShippingAddress.find(params[:id])
    if @shipping_address.customer == current_customer
      render "edit"
    else
      redirect_to shipping_addresses_path
    end
  end

  def update
    @shipping_address = ShippingAddress.find(params[:id])
    if @shipping_address.update(shipping_address_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to shipping_addresses_path
    else
      render :edit
    end
  end

  def destroy
    shipping_address = ShippingAddress.find(params[:id])
    shipping_address.destroy
    redirect_to shipping_addresses_path
  end

  private
  # ストロングパラメータ
  def shipping_address_params
    params.require(:shipping_address).permit(:customer_id, :shipping_name, :shipping_address, :shipping_post_code)
  end

end
