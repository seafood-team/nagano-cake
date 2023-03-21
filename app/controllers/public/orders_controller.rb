class Public::OrdersController < ApplicationController

  def new
    @order = Order.new

  end

  def index
    @order_details = OrderDetail.all
    @orders = Order.all
  end

  def create # Order に情報を保存

    # ログインユーザーのカートアイテムをすべて取り出して carts に入れる
    carts = current_customer.carts.all
    # 渡ってきた値を @order に入れる
    @order = current_customer.orders.new(order_params)

    if @order.save

      carts.each do |cart|

      # order_details にも一緒にデータを保存する必要があるのでここで保存
        order_details = OrderDetail.new
        order_details.product_id = cart.product_id
        order_details.order_id = @order.id
        # 購入が完了したらカート情報は削除するのでこちらに保存
        order_details.amount = cart.amount
        order_details.price = cart.product.with_tax_price
        order_details.making_status = 0

        order_details.save
      end
      redirect_to order_thanks_path
      # ユーザーに関連するカートのデータ(購入したデータ)をすべて削除(カートを空にする)
      carts.destroy_all
    else
      @order = Order.new(order_params)
      render :new
    end
  end

  def check
    @order = Order.new(order_params)

    # new 画面から渡ってきたデータを @order に入れる
    if params[:order][:address_number] == "1"# view で定義している address_number が"1"だったときにこの処理を実行

    # 登録済みの住所を保存
      @order.post_code = current_customer.post_code
      @order.address = current_customer.city
      @order.customer_name = (current_customer.last_name + current_customer.last_name)

    elsif params[:order][:address_number] == "2" # address_number が"2"だったときにこの処理を実行

      if ShippingAddress.exists?(id: params[:order][:registered])

        # 追加した新しいお届け先を保存
        @order.post_code = ShippingAddress.find(params[:order][:registered]).shipping_post_code
        @order.address = ShippingAddress.find(params[:order][:registered]).shipping_address
        @order.customer_name = ShippingAddress.find(params[:order][:registered]).shipping_name
      else
        render :new
      end
    elsif params[:order][:address_number] == "3"# address_number が"3"だったときにこの処理を実行

      new_address = Order.new(order_address_params)
      new_address.customer_id = current_customer.id
      shipping_address = ShippingAddress.new(shipping_address_params)
      shipping_address.customer_id = current_customer.id

      if new_address.save
        shipping_address.shipping_post_code = new_address.post_code
        shipping_address.shipping_address = new_address.address
        shipping_address.shipping_name = new_address.customer_name
      else
        render :new
      end
    else
      redirect_to order_thanks_path
    end
    @cart_products = current_customer.carts.all # カートアイテムの情報をユーザーに確認してもらうために使用
    @total = @cart_products.inject(0) { |sum, product| sum + product.subtotal }# 合計金額を出す処理です subtotal はモデルで定義したメソッド

  end

  private

  def order_params
    params.require(:order).permit(:post_code, :address, :customer_name, :shipping_cost)
  end

  def order_address_params
    params.require(:order).permit(:post_code, :address, :customer_name)
  end

  def shipping_address_params
    params.require(:order).permit(:shipping_post_code, :shipping_address, :shipping_name)
  end

end
