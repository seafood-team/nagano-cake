class Public::ShippingAddressesController < ApplicationController

  def index
    @shipping_address = ShippingAddress.new
    @shipping_addresses = ShippingAddress.all
  end

  def create
    # 新規作成する配送先データを格納
    shipping_address = ShippingAddress.new(list_params)

    shipping_address.save
    # 4. トップ画面へリダイレクト
    redirect_to '/shipping_addresses'
  end

  def edit

  end

  def update

  end

  def destroy

  end

  private
  # ストロングパラメータ
  def shipping_address_params
    params.require(:ShippingAddress).permit(:customer_id, :shipping_name, :shipping_address, :shipping_post_code)
  end

end
